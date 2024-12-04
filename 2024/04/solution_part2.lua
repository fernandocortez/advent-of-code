-- local file = io.open("test_input_1.txt", "r")
local file = io.open("puzzle_input.txt", "r")
if not file then error("File not found") end

---@type table<integer, string>
local word_search = {}
for line in file:lines() do
    table.insert(word_search, line)
end
file:close()

---@param table table<integer, string>
---@param line_num integer
---@param index integer
---@return boolean
local function is_diagonal_down_right(table, line_num, index)
    local M = string.sub(table[line_num-1] or "", index-1, index-1)
    local S = string.sub(table[line_num+1] or "", index+1, index+1)
    return M == "M" and S == "S"
end

---@param table table<integer, string>
---@param line_num integer
---@param index integer
---@return boolean
local function is_diagonal_down_left(table, line_num, index)
    local M = string.sub(table[line_num-1] or "", index+1, index+1)
    local S = string.sub(table[line_num+1] or "", index-1, index-1)
    return M == "M" and S == "S"
end

---@param table table<integer, string>
---@param line_num integer
---@param index integer
---@return boolean
local function is_diagonal_up_right(table, line_num, index)
    local M = string.sub(table[line_num+1] or "", index-1, index-1)
    local S = string.sub(table[line_num-1] or "", index+1, index+1)
    return M == "M" and S == "S"
end

---@param table table<integer, string>
---@param line_num integer
---@param index integer
---@return boolean
local function is_diagonal_up_left(table, line_num, index)
    local M = string.sub(table[line_num+1] or "", index+1, index+1)
    local S = string.sub(table[line_num-1] or "", index-1, index-1)
    return M == "M" and S == "S"
end

local count = 0
for line_num, line in ipairs(word_search) do
    local index = 1
    local max_len = #line
    while index <= max_len do
        local a_idx = string.find(line, "A", index)
        if not a_idx then
            break
        end

        local has_down_right = is_diagonal_down_right(word_search, line_num, a_idx)
        local has_down_left = is_diagonal_down_left(word_search, line_num, a_idx)
        local has_up_right = is_diagonal_up_right(word_search, line_num, a_idx)
        local has_up_left = is_diagonal_up_left(word_search, line_num, a_idx)
        if has_down_right and (has_down_left or has_up_right) then
            count = count + 1
        elseif has_down_left and has_up_left then
            count = count + 1
        elseif has_up_right and has_up_left then
            count = count + 1
        end
        index = a_idx + 1
    end
end
print (count)
