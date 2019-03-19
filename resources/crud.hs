#!/usr/bin/env stack
-- stack --resolver=lts-13.12 script
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

import qualified Control.Concurrent.STM.TVar as TVar
import Control.Concurrent.STM.TVar (TVar)
import Control.Monad (forM)
import Control.Monad.IO.Class (liftIO)
import qualified Control.Monad.STM as STM
import Control.Monad.Trans.Reader
import Data.Aeson (FromJSON, ToJSON)
import qualified Data.Aeson as J
import qualified Data.Map as Map
import Data.Map (Map)
import qualified Data.Text as T
import Data.Text (Text)
import GHC.Generics
import qualified Network.Wai.Handler.Warp as Warp
import Network.Wai.Middleware.Cors (simpleCors)
import Servant
import Servant.API.Generic ((:-), ToServantApi, genericApi)
import Servant.Server.Generic (AsServerT, genericServerT)

jsonOpts = J.defaultOptions {J.fieldLabelModifier = J.camelTo2 '_' . drop 3}

data CreateUserForm = CreateUserForm
  { cufName :: Text
  , cufSurname :: Text
  } deriving (Show, Generic)

instance ToJSON CreateUserForm where
  toJSON = J.genericToJSON jsonOpts

instance FromJSON CreateUserForm where
  parseJSON = J.genericParseJSON jsonOpts

data UpdateUserForm = UpdateUserForm
  { uufName :: Text
  , uufSurname :: Text
  } deriving (Show, Generic)

instance ToJSON UpdateUserForm where
  toJSON = J.genericToJSON jsonOpts

instance FromJSON UpdateUserForm where
  parseJSON = J.genericParseJSON jsonOpts

data UserInfo = UserInfo
  { uinId :: Int
  , uinName :: Text
  , uinSurname :: Text
  } deriving (Show, Generic)

instance ToJSON UserInfo where
  toJSON = J.genericToJSON jsonOpts

instance FromJSON UserInfo where
  parseJSON = J.genericParseJSON jsonOpts

data API route = API
  { _ping :: route :- "api" :> "ping" :> Get '[ PlainText] Text
  , _listUsers :: route :- "api" :> "users" :> "list.json" :> Get '[ JSON] [UserInfo]
  , _createUser :: route :- "api" :> "users" :> "create.json" :> ReqBody '[ JSON] CreateUserForm :> Post '[ JSON] UserInfo
  , _updateUser :: route :- "api" :> "users" :> Capture "user-id" UserId :> "update.json" :> ReqBody '[ JSON] UpdateUserForm :> Put '[ JSON] UserInfo
  , _deleteUser :: route :- "api" :> "users" :> Capture "user-id" UserId :> "delete.json" :> Delete '[ JSON] ()
  , _static :: route :- Raw
  } deriving (Generic)

api :: Proxy (ToServantApi API)
api = genericApi (Proxy :: Proxy API)

server :: API (AsServerT AppM)
server =
  API
    { _ping = pure "pong"
    , _listUsers = listUsers
    , _createUser = createUser
    , _updateUser = updateUser
    , _deleteUser = deleteUser
    , _static = serveDirectoryFileServer "."
    }

listUsers :: AppM [UserInfo]
listUsers = do
  env <- ask
  users <- liftIO $ TVar.readTVarIO (envUsers env)
  forM (Map.toList users) $ \(userId, User {..}) -> do
    pure $ UserInfo userId usrName usrSurname

createUser :: CreateUserForm -> AppM UserInfo
createUser CreateUserForm {..} = do
  env <- ask
  c <-
    liftIO $
    STM.atomically $ do
      c <- TVar.readTVar (envCounter env)
      TVar.modifyTVar (envCounter env) (+ 1)
      let user = User {usrName = cufName, usrSurname = cufSurname}
      TVar.modifyTVar (envUsers env) (Map.insert c user)
      pure c
  pure $ UserInfo c cufName cufSurname

updateUser :: UserId -> UpdateUserForm -> AppM UserInfo
updateUser userId UpdateUserForm {..} = do
  env <- ask
  liftIO $
    STM.atomically $ do
      let user = User {usrName = uufName, usrSurname = uufSurname}
      TVar.modifyTVar (envUsers env) (Map.insert userId user)
  pure $ UserInfo userId uufName uufSurname

deleteUser :: UserId -> AppM ()
deleteUser userId = do
  env <- ask
  liftIO $
    STM.atomically $ do TVar.modifyTVar (envUsers env) (Map.delete userId)

type UserId = Int

data User = User
  { usrName :: Text
  , usrSurname :: Text
  }

data Env = Env
  { envUsers :: TVar (Map UserId User)
  , envCounter :: TVar Int
  }

type AppM = ReaderT Env Servant.Handler

nt :: Env -> AppM a -> Servant.Handler a
nt s x = runReaderT x s

main :: IO ()
main = do
  putStrLn "Launching on http://localhost:8000"
  putStrLn "Put this script in directory with your html, it will be served. For example, if your homework is at Homework.html, you'll see it under http://localhost:8000/Homework.html"
  tv <- STM.atomically $ TVar.newTVar (Map.fromList [])
  counter <- TVar.newTVarIO 1
  let env = Env tv counter
  Warp.run
    8000
    (simpleCors
       (serve
          (Proxy :: Proxy (ToServantApi API))
          (hoistServer
             (Proxy :: Proxy (ToServantApi API))
             (nt env)
             (genericServerT server))))
