-- Two dashes start a one-line comment.

--[[
    Adding two ['s and ]'s makes it a
    multi-line comment
]]

-- Good practice tip
--[[
    this is a comment line, if you want disable comment,
    just delete the one of the "-" character in the previous line begin.
--]]

----------------------------------------------------------------------------------------------------
-- 1. Variable and flow control
----------------------------------------------------------------------------------------------------

Num = 42

-- All numbers are doubles, lua only have the float type variable
-- Don't freak out, 64-bit doubles have 52 bits for storing exact int values;
-- maching precision is not a problem for ints that need < 52 bits.

S = 'walternate'                            -- Immutable strings like Python.
T = "double-quotes are also fine"
LongString = [[ Double brackets
        start  and end
        multi-line strings.
    ]]

io.write(LongString, "\n")
T = nil                                     -- Unused T; Lua has garbage collection.

-- Formated string to output
print(string.format("Pi = %.10f", math.pi))

-- Blocks are denoted with keywords like do/end.
while (Num < 50) do
    Num = Num + 1               -- No ++ or += type operators
end

-- If clauses:
if num > 40 then
    print('over 40')
elseif s ~= 'walternate' then       -- ~= is not equals.
                                    -- Equality check is == like Python: ok for strs,.
    io.write('not over 40\n')       -- Defaults to stdout.
else
                                    -- Variables are global by default.
    ThisIsGlobal = 5                -- Camel case is common.
                                    -- How to make a variable local:
    local line = io.read()          -- Read next stdin line.

                                    -- String concatenation uses the ".." operator:
    print('Winter is coming,' .. line)
end

-- Undefined variables return nil.
-- This is not an error:

Foo = auUnknownVariable             -- Now foo = nil.

ABoolValue = false

                                    -- Only nil and false are false; 0 and '' are true!
if not ABoolValue then
    print('twas false')
end

-- 'or' and 'and' are short-circuited.
-- This is similar to she a?b:c operator in C/js:

Ans = ABoolValue and 'yes' or 'no'          --> 'no'

local kerlSum = 0
for i = 1, 100 do                           -- The range includes both ends.
    kerlSum = kerlSum + i
end

-- 2d array
local aTable = {}
for i = 0,9 do
  aTable[i] = {}
  for j = 0,9 do
    aTable[i][j] = tostring(i) .. tostring(j)
  end
end

for i = 0,9 do
  for j = 0,9 do
    io.write(aTable[i][j], ":")
  end
  print()
end


-- In general, the range is "begin, end[, step]".
-- Use "100, 1, -1" as the range to count down:
local fredSum = 0
for j = 100, 1, -1 do
    fredSum = fredSum + j
end

--Another loop construct:
local num = 10
repeat
    print('the way of the future')
    num = num - 1
until num == 0

-- 2. Functions.

function fib(n)
    if n < 2 then return 1 end
    return fib(n - 2) + fib(n - 1)
end

print(string.format("fib(2) = ", fib(2)))

function splitStr(theString)
  stringTable = {}
  local i = 1

  for word in string.gmatch(theString, "[^%s]+") do
    stringTable[i] = word
    i = i + 1
  end

  return stringTable, i
end

splitStrTable, numOfStr = splitStr("The Turtle")

for j = 1, numOfStr - 1 do
  print(string.format("%d : %s", j, splitStrTable[j]))
end

function getSumMore(...)
  local sum = 0

  for k, v in paris{...} do
    sum = sum + v
  end
  return sum
end

print("Sum ", getSumMore(1, 2, 3, 4, 5 ,6))


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


LoudDog = Dog::new()

function LoudDog::makeSound()
	s = self.sound .. ' '
	print(s .. s .. s)
end

seymour = LoudDog::new()
seymour:makeSound()


-- If needed, a subclass's new() is like the base's:
function LoudDog:new()
	newObj = {}
	self.__index = self
	return setmetatable(newObj, self)
end

-- 4. Modules

--[[ I'm commenting out this section so the rest of
--   this script remains runnable.
-- Suppose the file mod.lua looks like this:
local M = {}

local function sayMyName()
  print('Hrunkner')
end

function M.sayHello()
  print('Why hello there')
  sayMyName()
end

return M

-- Another file can use mod.lua's functionality:
local mod = require('mod')  -- Run the file mod.lua.

-- require is the standard way to include modules.
-- require acts like:     (if not cached; see below)
local mod = (function ()
  <contents of mod.lua>
end)()
-- It's like mod.lua is a function body, so that
-- locals inside mod.lua are invisible outside it.

-- This works because mod here = M in mod.lua:
mod.sayHello()  -- Says hello to Hrunkner.

-- This is wrong; sayMyName only exists in mod.lua:
mod.sayMyName()  -- error

-- require's return values are cached so a file is
-- run at most once, even when require'd many times.

-- Suppose mod2.lua contains "print('Hi!')".
local a = require('mod2')  -- Prints Hi!
local b = require('mod2')  -- Doesn't print; a=b.

-- dofile is like require without caching:
dofile('mod2.lua')  --> Hi!
dofile('mod2.lua')  --> Hi! (runs it again)

-- loadfile loads a lua file but doesn't run it yet.
f = loadfile('mod2.lua')  -- Call f() to run it.

-- loadstring is loadfile for strings.
g = loadstring('print(343)')  -- Returns a function.
g()  -- Prints out 343; nothing printed before now.

--]]


































