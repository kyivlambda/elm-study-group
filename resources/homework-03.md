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
find f xs = Debug.todo ""

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
keepOks xs = Debug.todo ""

> keepOks [Ok 1, Err "bad", Ok 2]
[1,2] : List number
```

**mapOk**

```elm
mapOk : (b -> c) -> Result a b -> Result a c
mapOk f res = Debug.todo ""

> mapOk (\x -> x + 1) (Ok 2)
Ok 3 : Result a number
> mapOk (\x -> x + 1) (Err "str")
Err "str" : Result String number
```

**either**

```elm
either : (a -> c) -> (b -> c) -> Result a b -> c
either fa fb res = Debug.todo

> either (\x -> x + 1) (\x -> x - 1) (Ok 1)
0 : number
> either (\x -> x + 1) (\x -> x - 1) (Err 1)
2 : number
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

**Timer**

Implement "Timer" from http://eugenkiss.github.io/7guis/tasks/

Some additional notes:

- see html at https://guide.elm-lang.org/interop/ used together with
  `elm make --output=out/YourApp.js` to compile to JS and be able to
  include CSS like bootstrap in your timer app
- use the `Time` module from `elm/time` package to get current time
  and subscribe to periodic updates
  https://package.elm-lang.org/packages/elm/time/1.0.0/Time
- use `Task.perform` function to convert a `Task` into a command.
  For example:

  ```elm
  import Time

  type Msg
    ...
    | GotInitialTime Time.Posix

  update : Msg -> Model -> ( Model, Cmd Msg )
  update =
    ...
    ( model
    , Task.perform GotInitialTime Time.now
    )
    ...
  ```

  See https://package.elm-lang.org/packages/elm/core/latest/Task
- use subscription mechanism to subscribe to periodic time changes. For example:

  ```elm
  ...

  type Msg =
    ...
    | TimeUpdate Time.Posix

  ...

  subscriptions : Model -> Sub Msg
  subscriptions model =
      Time.every 200.0 TimeUpdate

  main : Program () Model Msg
  main =
      Browser.element
          { init = init
          , view = view
          , update = update
          , subscriptions = subscriptions
          }
  ```

**(optional) Graceful Labeling**

Graceful Labeling from
https://johncrane.gitbooks.io/ninety-nine-elm-problems/content/p/p92.html
