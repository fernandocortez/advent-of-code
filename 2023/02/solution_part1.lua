-- local file = io.open("test_input_1.txt", "r")
local file = io.open("puzzle_input.txt", "r")
if not file then error("File not found") end

local possible_game = { red = 12, green = 13, blue = 14 }

local result = 0
for line in file:lines() do
    local game = line
    -- removes the text "Game" from the line w/ trailing space
    game = string.sub(line, 6)

    local game_id = string.match(game, "%d+")
    -- removes the game id, semicolon, and empty space
    game = string.sub(game, #game_id + 2)

    local is_possible_game = true
    for game_set in string.gmatch(game, "%d+%s%w+") do
        local white_space_index = string.find(game_set, "%s")
        local count = tonumber(string.sub(game_set, 1, white_space_index - 1), 10)
        local color = string.sub(game_set, white_space_index + 1)
        if count > possible_game[color] then
            is_possible_game = false
            break
        end
    end
    if is_possible_game then
        result = result + tonumber(game_id, 10)
    end
end
print(result)
