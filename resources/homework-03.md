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

