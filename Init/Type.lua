#!/usr/bin/env lua
-- file: boolean.lua
-- Exercise 3.5: How can you check whether a value is boolean
-- without using the type function?

-- check if a variable is a boolean
-- comparisons are false if the types are different
local function is_boolean(v)
    return v == true or v == false
end

function Type(x)
    return is_boolean(x) and "true" or "false"
end

-- test the function with some examples
local num = 123
local str = "str"
local bool = true

print("is_boolean(123)   --> " .. (is_boolean(num) and "true" or "false"))
print("is_boolean('str') --> " .. (is_boolean(str) and "true" or "false"))
print("is_boolean(true)  --> " .. (is_boolean(bool) and "true" or "false"))
