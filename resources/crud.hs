#!/usr/bin/env stack
-- stack --resolver=lts-13.12 script
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

import qualified Control.Concurrent.STM.TVar as TVar
import Control.Concurrent.STM.TVar (TVar)
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
import Servant
import Servant.API.Generic ((:-), ToServantApi, genericApi)
import Servant.Server.Generic (AsServerT, genericServerT)

data CreateUserForm = CreateUserForm
  { cufName :: Text
  , cufSurname :: Text
  } deriving (Show, Generic)

jsonOpts = J.defaultOptions {J.fieldLabelModifier = J.camelTo2 '_' . drop 3}

instance ToJSON CreateUserForm where
  toJSON = J.genericToJSON jsonOpts

instance FromJSON CreateUserForm where
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
  , _createUser :: route :- "api" :> "users" :> "create.json" :> ReqBody '[ JSON] CreateUserForm :> Post '[ JSON] UserInfo
  } deriving (Generic)

api :: Proxy (ToServantApi API)
api = genericApi (Proxy :: Proxy API)

server :: API (AsServerT AppM)
server = API {_ping = pure "pong", _createUser = createUser}

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
  tv <- STM.atomically $ TVar.newTVar (Map.fromList [])
  counter <- TVar.newTVarIO 1
  let env = Env tv counter
  Warp.run
    8000
    (serve
       (Proxy :: Proxy (ToServantApi API))
       (hoistServer
          (Proxy :: Proxy (ToServantApi API))
          (nt env)
          (genericServerT server)))
