# Homework Week 2

**Map one structure to another**

```elm
convert 
  : List { name : String, email : String, phone_number : String}
  -> List { name : String, email : String}
  = Debug.todo ""
```

**Filter elements with non-empty name and email**

```elm
convert02 
  : List { name : Maybe String, email : Maybe String} 
  -> List { name : String, email : String} 
  = Debug.todo ""
```

**Fill in missing names with `<unspecified>`, while removing elements with no email**

```elm
convert03 
  : List { name : Maybe String, email : Maybe String} 
  -> List { name : String, email : String} 
  = Debug.todo ""
```

