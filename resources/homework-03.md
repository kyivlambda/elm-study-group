# Homework Week 3

**maybeToList**

```elm
maybeToList : Maybe a -> List a
maybeToList x = Debug.todo ""
```

**updateList**

```elm
updateList : (a -> Bool) -> (a -> Maybe a) -> List a -> List a
updateList shouldChange f xs = Debug.todo ""
```

**find**

```elm
find : (a -> Bool) -> List a -> Maybe a
find f xss = Debug.todo ""
```

``isJust``

```elm
isJust : Maybe a -> Bool
isJust v = Debug.todo ""
```

**Implement updateListKv**

```elm
updateListKv :
  List (k, v)
  -> k
  -> (v -> Maybe v)
  -> List (k, v)
updateListKv old k f = Debug.todo ""

> updateListKv [("foo", 1), ("bar", 2)] "foo" (\x -> Just (x + 1))
[("foo", 2), ("bar", 2)]
> updateListKv [("foo", 1), ("bar", 2)] "foo" (\x -> Nothing)
[("bar", 2)]
```

**updateArray**

```elm
updateArray : Array a -> (a -> Bool) -> (a -> b) -> Array b
updateArray = Debug.todo ""
```

**keepOks**

```elm
keepOks : List (Result a b) -> List b
keepOks e = Debug.todo ""
```

**mapOk**

```elm
mapOk : (b -> c) -> Result a b -> Result a c
```

**either**

```elm
either : (a -> c) -> (b -> d) -> Result a b -> Result c d
```

**maybe**

```elm
maybe : a -> (b -> a) -> Maybe b -> a
```

**updateUserProfileEmail**

```elm
type alias User =
  { name : String
  , profile : Maybe Profile
  }

type alias Profile =
  { email : Maybe String
  , avatar : Maybe String
  }

type alias Model =
  { user : User }
  
updateUserProfileEmail : String -> Model -> Model
updateUserProfileEmail email model = Debug.todo ""
```

