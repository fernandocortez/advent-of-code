-- local file = io.open("test_input_1.txt", "r")
local file = io.open("puzzle_input.txt", "r")
if not file then error("File not found") end

local result = 0
for line in file:lines() do
    local game = ''
    -- removes the text "Game" from the line w/ trailing space
    game = string.sub(line, 6)

    local game_id = string.match(game, "%d+")
    -- removes the game id, semicolon, and empty space
    game = string.sub(game, #game_id + 2)

    local min_possible_cubes = {}
    for game_set in string.gmatch(game, "%d+%s%w+") do
        local white_space_index = string.find(game_set, "%s")
        local count = tonumber(string.sub(game_set, 1, white_space_index - 1), 10)
        local color = string.sub(game_set, white_space_index + 1)

        local min_count = min_possible_cubes[color]
        if min_count == nil or count > min_count then
            min_possible_cubes[color] = count
        end
    end

    local power = 1
    for _, val in pairs(min_possible_cubes) do
        power = power * val
    end
    result = result + power
end
print(result)
