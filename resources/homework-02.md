# Homework Week 2

**Map one structure to another**

```elm
convert 
  : List { name : String, email : String, phone_number : String}
  -> List { name : String, email : String}
  = Debug.todo ""
> convert [{name="John", email="john@gmail.com", phone_number="+3801234567"}]
[{name="John", email="john@gmail.com"}]
```

**Filter elements with non-empty name and email**

```elm
convert02 
  : List { name : Maybe String, email : Maybe String} 
  -> List { name : String, email : String} 
  = Debug.todo ""
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

**TODO: `<|`, `|>`**

**TODO: Maybe.map, Maybe.andThen**

**TODO: partial application**

**TODO: anonymous function**

**TODO: setter pattern**

**mapMaybes**

```elm
mapMaybes : (a -> Maybe b) -> List a -> List b
mapMaybes = Debug.todo ""
```

**catMaybes**

```
catMaybes : List (Maybe a) -> List a
catMaybes = Debug.todo ""
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

**Make a mini application**

Make a mini application consisting of a textual input, and a button
"send". Upon pressing a button, it must check whether the field is
empty. If it is -- render red "value cannot be empty". If it isn't
empty but has no `@` sign in it, render "email must contain a @
sign". Otherwise -- render blue message "Email sent successfully"**

**(optional) Eight Queens**

Very famous Eight Queens Problem. Please see
https://johncrane.gitbooks.io/ninety-nine-elm-problems/content/p/p90.html
for details.
