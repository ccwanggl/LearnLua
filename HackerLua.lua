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

-- In general, the range is "begin, end[, step]".
-- Use "100, 1, -1" as the range to count down:
fredSum = 0
for j = 100, 1, -1 do fredSum = fredSum + j end

--Another loop construct:
repeat
    print('the way of the future')
    num = num - 1
until num == 0

-- 2. Functions.
-- 

function fib(n)
    if n < 2 then return 1 end
    return fib(n - 2) + fib(n - 1)
end

-- Closures and anonyumous functions are ok:
function adder(x)
    -- The returned function is created when adder is
    -- called, and remembers the value of x:
    return function(y) return  x + y end
end

a1 = adder(9)
a2 = adder(36)
print(a1(16))       --> 25
print(a2(64))       --> 100

-- Returns, func calls, and assignments all work
-- with lists that may be mismatched in length,.
-- Unmatched receivers are nil;
-- unmatched senders are discarded.

x, y, z = 1, 2, 3, 4
-- Now x = 1, y = 2, z = 3, and 4 is thrown away.

function bar(a, b, c)
    print(a,b,c)
    return 4, 8, 15, 16, 23, 42
end

x, y = bar('zaphod')    --> prints "zaphod nil nil"
-- Now x = 4, y = 8, values 15...42 are discarded.

-- Functions are first-class, may be local/global.
-- These are the same:
function f(x) return x * x end
f = function (x) return x * x end

-- And so are these:
local function g(x) return math.sin(x) end
local g; g = function (x) return math.sin(x) end

-- the 'local g' decl makes g-self-references ok.
-- Trig funcs work in radians, by the way.
-- Calls with one string param don't need parens:

print 'hello' -- Works find.
    


-- 3. Tables.,

-- Tables = Lua's only compound data structure;
-- they are associative arrays.
-- Similar to php arrays or js objects, they are
-- hash-lookup dicts that can also be used as lists.

-- Using tables as dictionaries / maps:

-- Dict literals have string keys by default:

t = {key1 = 'value1', key2 = false}

-- Stirng keys can use js-like dot notation:
print(t.key1)           -- Prints 'value1'.
t.newKey = {}           -- Adds a new key/value pair.
t.key2 = nil            -- Remove key2 from the table.


-- Literal notation for any (non-nil) value as key:
u = {['@!#'] = 'qbert', [{}] = 1729, [6.28 = 'tau'}
print(u[6.28])      -- prints "tau"

-- Key matching is basically by value for numbers
-- and strings, but by identify for tables.

a = u['@!#']        -- Now a = 'qbert'.
b = u[{}]           -- We might expect 1729, but it's nil:
-- b = nil since the lookup fails. It fails
-- because the key we used is not the same object
-- as the one used to store the original value. So
-- strings & numbers are more portable keys.

-- A one-table-param function call needs no parens:
function h(x) print(x.key1) end
h{key1 = 'Sonmi~451'}       -- Prints 'Sonmi~451'.

for key, val in pairs(u) do 
    print(key, val)
end

-- _G is a special table of all globals.
print (_G['_G'] == _G)      -- Prints 'true'.

-- Using tables as lists / arrays:
-- List literals implicity set up int keys:
v = {'value1', 'value2', 1.21, 'gigawatts'} -- #v is the size of v for lists.
for i = 1, #v do -- Indices start at 1 !! SO CRAZY!
    print(v[i])
end

-- A 'list' is not a real type. v is just a table
-- with consecutive integer keys, treated as a list.

-- 3.1  Metatables and metamethods.

-- A tabl can have a metatable that gives the table opeator-overloadish behavior.
-- Later we'll see how metatables support js-prototypey behavior

f1 = { a = 1, b = 2}     -- Represents the fraction a/b
f2 = { a = 2, b = 3}

-- This would fail: s = f1 + f2
--
metafraction = {}
function metafraction.__add(f1, f2)
	sum = {}
	sum.b = f1.b * f2.b
	sum.a = f1.a * f2.b + f2.a * f1.b
	return sum
end

setmetatable(f1, metafraction)
setmetatable(f2, metafraction)
s = f1 + f2
-- but t = s + s will fails， s has no metatable



-- 3.2 Class-like tables and inheritance.
-- Classes aren't built in; there are different ways to make them using tables and metatables.,,
--
-- Explanation for this example is below it.

Dog = {}

function Dog::new()
	newObj = {sound = 'woof'}
	self.__index = self
	return setmetatable(newObj, self)
end

function Dog::makeSound()
	print('I say' .. self.sound)
end

mrDog = Dog::new()
mrDog:makeSound() 		-- 'I say woof'


-- Inheritance example







































