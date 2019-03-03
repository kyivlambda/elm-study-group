# Homework Week 2

**Map one structure to another**

```elm
convert 
  : List { name : String, email : String, phone_number : String}
  -> List { name : String, email : String}
convert = Debug.todo ""
> convert [{name="John", email="john@gmail.com", phone_number="+3801234567"}]
[{name="John", email="john@gmail.com"}]
```

**Filter elements with non-empty name and email**

```elm
convert02 
  : List { name : Maybe String, email : Maybe String} 
  -> List { name : String, email : String} 
convert02 = Debug.todo ""
> convert02 [{name=Just "John", email=Just "john@gmail.com"}]
[{name="John", email="john@gmail.com"}]
```

**Fill in missing names with `<unspecified>`, while removing elements
with no email**

```elm
convert03 
  : List { name : Maybe String, email : Maybe String} 
  -> List { name : String, email : String} 
  = Debug.todo ""
> convert03 [{name=Just "John", email=Nothing}]
[{name="John", email="<unspecified>"}]
```

**Rewrite bird using `<|`, then using `|>` instead of parens (where applicable)**

```elm
bird : Int
bird =
    let
        notThree x =
            x /= 3

        incr x =
            x + 1
    in
    List.sum (List.filter notThree (List.map incr [ 1, 2, 3 ]))

-- using <|
bird2 = Debug.todo ""

-- using |>
bird3 = Debug.todo ""
```

**Implement setPhone**

```elm
type alias User = { profile : Profile }
type alias Profile = { address : Address }
type alias Address = { phone : String }

setPhone : String -> User -> User
setPhone = Debug.todo ""

> setPhone "+123456" { profile = { address = { phone = "+654321" } } }
{ profile = { address = { phone = "+123456" } } }

**mapMaybes**

```elm
isJust x =
  case x of
    Nothing -> False
    _ -> True

mapMaybes : (a -> Maybe b) -> List a -> List b
mapMaybes = Debug.todo ""

> mapMaybes (\x -> if x == Just 3 then x else Just 4) [Just 1, Nothing, Just 3]
[4,4,3] : List number
```

**catMaybes**

```elm
catMaybes : List (Maybe a) -> List a
catMaybes = Debug.todo ""

> catMaybes [Just 1, Nothing, Just 3]
[1,3] : List number
```

**Use package [elm/url](https://package.elm-lang.org/packages/elm/url/latest) and its Url.Builder.absolute to build URL from parameters**

```elm
buildStatsUrl : Int -> { startDate : Maybe String, numElems : Maybe Int } -> String
buildStatsUrl itemId ps =
  Debug.todo ""

> buildStatsUrl 12 Nothing Nothing
https://myapi.com/api/item/12/stats.json
> buildStatsUrl 12 (Just "2019-01-01") Nothing
https://myapi.com/api/item/12/stats.json?start_date=2019-01-01
> buildStatsUrl 12 (Just "2019-01-01") (Just 10)
https://myapi.com/api/item/12/stats.json?start_date=2019-01-01&num_items=10
```

See if using catMaybes would help as number of GET-parameters will grow

**Temperature converter**

Implement "Temperature Converter" from 7GYUs as described in https://eugenkiss.github.io/7guis/tasks

**(optional) Eight Queens**

Very famous Eight Queens Problem. Please see
https://johncrane.gitbooks.io/ninety-nine-elm-problems/content/p/p90.html
for details.
