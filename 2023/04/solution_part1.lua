-- local file = io.open("test_input_1.txt", "r")
local file = io.open("puzzle_input.txt", "r")
if not file then error("File not found") end

local sum = 0
for line in file:lines() do
    local index_of_colon = string.find(line, ":")
    local card = string.sub(line, index_of_colon + 1)

    local index_of_pipe = string.find(card, "|")
    local winning_numbers = {}
    for winning_number in string.gmatch(string.sub(card, 1, index_of_pipe - 1), "%d+") do
        winning_numbers[winning_number] = winning_number
    end

    local winning_numbers_count = 0
    local scratched_numbers = string.sub(card, index_of_pipe + 1)
    for digits in string.gmatch(scratched_numbers, "%d+") do
        local is_winning_number = winning_numbers[digits]
        if is_winning_number ~= nil then
            winning_numbers_count = winning_numbers_count + 1
        end
    end
    if winning_numbers_count > 0 then
        sum = sum + 2 ^ (winning_numbers_count - 1)
    end
end
print(sum)
