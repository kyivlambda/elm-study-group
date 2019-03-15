# Homework Week 4

TODO: regular JSON exercises
TODO: `Json.Decode.Pipeline`
TODO: Applicative-like stuff with Maybe
TODO: Applicative-like stuff with Json

**CRUD (minimal scope)**

Implement CRUD from http://eugenkiss.github.io/7guis/tasks/ without server calls

**CRUD (full scope)**

Use `./crud.hs` (or make your own web-server) and make actual HTTP/JSON calls. It works like this:

```
$ curl -Ss -H 'Content-Type: application/json' -XPOST --data '{"name": "Valentyn", "surname": "Silvestrov"}' localhost:8000/api/users/create.json
{"name":"Valentyn","id":3,"surname":"Silvestrov"}
```

**Morse Code**

Decode the Morse Code https://www.codewars.com/kata/decode-the-morse-code/elm
