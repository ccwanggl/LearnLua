# LearnLua
Learn lua with hand type "Learn X in Y minutes"
https://github.com/ccwanggl/LearnLua


# use `dofile` and `-l` load function

```lua
    -   lua -llib
    -   lua; dofile("function.lua")
```

# why `print(type(nil) == nil)` print false

    Beacuse of the function `type()` always returns a stirng, the value of `type()` is the string `"nil"`, which is not the same as `nil`, they have different type.