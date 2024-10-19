-- local file = io.open("test_input_1.txt", "r")
local file = io.open("puzzle_input.txt", "r")
if not file then error("File not found") end

local sum = 0
for line in file:lines() do
    local digits = {}
    for digit in string.gmatch(line, "%d") do
        table.insert(digits, tonumber(digit, 10))
    end

    local number_of_digits = #digits
    if number_of_digits == 1 then
        sum = sum + digits[1] * 10 + digits[1]
    elseif number_of_digits == 2 then
        sum = sum + digits[1] * 10 + digits[2]
    elseif number_of_digits > 2 then
        sum = sum + digits[1] * 10 + digits[number_of_digits]
    end
end
print(sum)
