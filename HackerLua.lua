-- Two dashes start a one-line comment.

-- [[
    Adding two ['s and ]'s makes it a
    multi-line comment
--]]

-- 1. Variable and flow control

num = 42    -- All numbers are doubles.
-- Don't freak out, 64-bit doubles have 52 bits for
-- storing exact int values: maching precision is
-- not a problem for ints that need < 52 bits.

s = 'walternate'        -- Immutable strings linke Python.
t = "double-quotes are also fine"
u = [[ Double brackets 
        start  and end
        multi-line strings.]]
        
t = nil -- Underlines t; Lua has garbage collection.

-- Blocks are denoted with keywords like do/end.
while num < 50 do 
    num < num + 1   -- No ++ or += type operators.
end

-- If clauses:
if num > 40 then
    print('over 40')
elseif s ~= 'walternate' then -- ~= is not equals.
    -- Equality check is == like Python: ok for strs,.
    io.write('not over 40\n') -- Defaults to stdout.
else
    -- Variables are global by default.
    thisIsGlobal = 5 -- Camel case is common.
    -- How to make a variable local:
    local line = io.read() -- Read next stdin line.
    
    -- String concatenation uses the .. operator:
    print('Winter is coming,' .. line)
end

-- Undefined variables return nil.
-- This is not an error:
foo = auUnknownVariable -- Now foo = nil.

aBoolValue = false

-- Only nil and false are falsy; 0 and '' are true!
if not aBoolValue then print('twas false') end

-- 'or' and 'and' are short-circuited.
-- This is similar to she a?b:c operator in C/js:
ans = aBoolValue and 'yes' or 'no'          --> 'no'

karlSum = 0
for i = 1, 100 do -- The range includes both ends.
    kerlSum = kerlSum + i
end