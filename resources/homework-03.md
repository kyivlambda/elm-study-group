# Homework Week 3

**maybeToList**

```elm
maybeToList : Maybe a -> List a
maybeToList x = Debug.todo ""

> maybeToList (Just 3)
[3]
> maybeToList Nothing
[]
```

**updateList**

Change or remove element if it matches the `shouldChange` test.

```elm
updateList : (a -> Bool) -> (a -> Maybe a) -> List a -> List a
updateList shouldChange f xs = Debug.todo ""

> updateList (\x -> x == 3) (\v -> Just (v + 1)) [1,3,5]
[1,4,5] : List number
> updateList (\x -> x == 3) (\v -> Nothing) [1,3,5]
[1,5] : List number
```

**find**

```elm
find : (a -> Bool) -> List a -> Maybe a
find f xss = Debug.todo ""

> find (\x -> x == 2) [1,3,5,2]
Just 2 : Maybe number
> find (\x -> x == 2) [1,3,5]
Nothing : Maybe number
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

**Implement `parseDate`**

Do `elm install justinmimbs/date` to get the package. Use
`Date.fromIsoString`.

```elm
import Date exposing (Date)

parseDate : Maybe String -> Maybe Date
parseDate v =
    Debug.todo ""
```

**maybe**

```elm
maybe : a -> (b -> a) -> Maybe b -> a
```

**Timer**

Implement "Timer" from http://eugenkiss.github.io/7guis/tasks/

**(optional) Graceful Labeling**

Graceful Labeling from
https://johncrane.gitbooks.io/ninety-nine-elm-problems/content/p/p92.html
