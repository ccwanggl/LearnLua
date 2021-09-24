-- defines a factorial functions
function Fact(n)
    if n == 0 then
        return 1

    else
        return n * Fact(n-1)
    end
end


print("enter a number:")
local a = io.read("*n")       -- read a number

if a < 0 then
    print("please input positive number:")
    return
end

print((Fact(a)))
