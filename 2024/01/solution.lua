-- local file = io.open("test_input_1.txt", "r")
local file = io.open("puzzle_input.txt", "r")
if not file then error("File not found") end

local left_list = {}
local right_list = {}
for line in file:lines() do
    local t = {}
    for value in string.gmatch(line, "%d+") do
        table.insert(t, tonumber(value, 10))
    end
    table.insert(left_list, t[1])
    table.insert(right_list, t[2])
end
file:close()

table.sort(left_list)
table.sort(right_list)

local function part1()
    local sum = 0
    for i, left_item in ipairs(left_list) do
        local distance = math.abs(left_item - right_list[i])
        sum = sum + distance
    end
    return sum
end

local function part2()
    local memo = {}
    for i, left_item in ipairs(left_list) do
        memo[left_item] = 0
    end

    for i, right_item in ipairs(right_list) do
        local count = memo[right_item]
        if count ~= nil then
            memo[right_item] = count + 1
        end
    end

    local sum = 0
    for i, left_item in ipairs(left_list) do
        sum = sum + (left_item * memo[left_item])
    end
    return sum
end

print("part 1: " .. part1())
print("part 2: " .. part2())
