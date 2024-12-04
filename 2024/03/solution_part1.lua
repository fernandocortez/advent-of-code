-- local file = io.open("test_input_1.txt", "r")
local file = io.open("puzzle_input.txt", "r")
if not file then error("File not found") end

local sum = 0
for line in file:lines() do
    for a, b in string.gmatch(line, "mul%((%d%d?%d?),(%d%d?%d?)%)") do
        sum = sum + (tonumber(a) * tonumber(b))
    end
end
file:close()
print(sum)
