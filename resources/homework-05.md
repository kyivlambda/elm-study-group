# Homework Week 5

**Write your own json package**

On our last session, we've implemented our own package, similar to `elm/json`. We implemented our own `Val` type that looks like this:

```elm
type Val
    = Str String
    | Num Int
    | Obj (List ( String, Val ))
    | Nil
    | Lst (List Val)
```

and presented a decoder as:

```elm
type MyJsonDecoder a
    = MyJsonDecoder (Val -> Result String a)
```


Now it's your turn to try and do the same. Implement these:

```elm
decodeValue : MyJsonDecoder a -> Val -> Result String a
decodeValue (MyJsonDecoder f) v =

myJsonString : MyJsonDecoder String
myJsonString = Debug.todo ""

myJsonInt : MyJsonDecoder Int
myJsonInt = Debug.todo ""

myJsonField : String -> MyJsonDecoder a -> MyJsonDecoder a
myJsonField = Debug.todo ""
```

pick other decoders you like from `elm/json`, implement similar ones. For advanced, try:

```elm
-- quite advanced
keyValPairs :
    MyJsonDecoder a
    -> MyJsonDecoder (List ( String, a ))
keyValPairs (MyJsonDecoder innerDec) =
  Debug.todo ""
```

If you are stuck, read through
https://gist.github.com/k-bx/0a96ef87d4dc8bc52ea49a81c34b674c , then
try again.

Test like this:

```
> decodeValue (myJsonInt) (Num 4)
Ok 4
> decodeValue (myJsonField "foo" myJsonInt) (Obj [("foo", Num 4)])
Ok 4
```

**Dependent parsing**

Implement a decoder `decodePath`:

```elm
type Path = PathFile String
          | PathUrl { host : String, port_ : Int }

decodePath : Decoder Path
decodePath = Debug.todo ""
```

for this structure:

```json
{"path_type": "file",
 "value": "/foo/bar"}
```

it would decode into `PathFile "/foo/bar"`, and this json:

```json
{"path_type": "url",
 "value": {"host": "http://example.com",
           "port": 80}}
```

would be decoded as `PathUrl { host="http://example.com", port_=80 }`

**Date picker**

Make a simple SPA that uses
[CurrySoftware/elm-datepicker](https://package.elm-lang.org/packages/CurrySoftware/elm-datepicker/latest/)
library.
