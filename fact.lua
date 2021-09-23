-- defines a factorial functions

function fact(n)
    if n == 0 then
        return 1

    else
        return n * fact(n-1)
    end
end


print("enter a number:")
a = io.read("*n")       -- read a number

if a < 0 then
    print("please input positive number:")
    return
end

print((fact(a)))