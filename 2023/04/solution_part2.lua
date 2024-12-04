-- local file = io.open("test_input_1.txt", "r")
local file = io.open("puzzle_input.txt", "r")
if not file then error("File not found") end

local winning_numbers_count_by_id = {}
for line in file:lines() do
    local index_of_colon = string.find(line, ":")
    local card_id = tonumber(string.sub(line, 6, index_of_colon - 1), 10)
    local card = string.sub(line, index_of_colon + 1)

    local index_of_pipe = string.find(card, "|")
    local winning_numbers = string.sub(card, 1, index_of_pipe - 1)
    local winning_numbers_table = {}
    for winning_number in string.gmatch(winning_numbers, "%d+") do
        winning_numbers_table[winning_number] = true
    end

    local winning_numbers_count = 0
    local scratched_numbers = string.sub(card, index_of_pipe + 1)
    for digits in string.gmatch(scratched_numbers, "%d+") do
        local is_winning_number = winning_numbers_table[digits]
        if is_winning_number then
            winning_numbers_count = winning_numbers_count + 1
        end
    end
    winning_numbers_count_by_id[card_id] = winning_numbers_count
end
file:close()

local winning_card_rewards_by_id = {}
for id, count in pairs(winning_numbers_count_by_id) do
    local rewards = {}
    for i = 1, count do
        table.insert(rewards, id + i)
    end
    winning_card_rewards_by_id[id] = rewards
end
winning_numbers_count_by_id = nil -- no longer needed

--
local sum = 0
local function handle_updating_card_copies(id, rewards)
    sum = sum + 1
    for _, card in pairs(rewards) do
        handle_updating_card_copies(card, winning_card_rewards_by_id[card])
    end
end

for id, rewards in pairs(winning_card_rewards_by_id) do
    handle_updating_card_copies(id, rewards)
end
print(sum)
