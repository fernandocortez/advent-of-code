-- local file = io.open("test_input_1.txt", "r")
local file = io.open("puzzle_input.txt", "r")
if not file then error("File not found") end

---@type table<integer, string>
local word_search = {}
for line in file:lines() do
    table.insert(word_search, line)
end
file:close()

---@param line string
---@param index integer
---@return boolean
local function is_horizontal(line, index)
    return string.sub(line, index, index+3) == "XMAS"
end

---@param line string
---@param index integer
---@return boolean
local function is_horizontal_backwards(line, index)
    return string.sub(line, index-3, index) == "SAMX"
end

---@param table table<integer, string>
---@param line_num integer
---@param index integer
---@return boolean
local function is_vertical(table, line_num, index)
    local M = string.sub(table[line_num+1] or "", index, index)
    local A = string.sub(table[line_num+2] or "", index, index)
    local S = string.sub(table[line_num+3] or "", index, index)
    return M == "M" and A == "A" and S == "S"
end

---@param table table<integer, string>
---@param line_num integer
---@param index integer
---@return boolean
local function is_vertical_backwards(table, line_num, index)
    local M = string.sub(table[line_num-1] or "", index, index)
    local A = string.sub(table[line_num-2] or "", index, index)
    local S = string.sub(table[line_num-3] or "", index, index)
    return M == "M" and A == "A" and S == "S"
end

---@param table table<integer, string>
---@param line_num integer
---@param index integer
---@return boolean
local function is_diagonal_down_right(table, line_num, index)
    local M = string.sub(table[line_num+1] or "", index+1, index+1)
    local A = string.sub(table[line_num+2] or "", index+2, index+2)
    local S = string.sub(table[line_num+3] or "", index+3, index+3)
    return M == "M" and A == "A" and S == "S"
end

---@param table table<integer, string>
---@param line_num integer
---@param index integer
---@return boolean
local function is_diagonal_down_left(table, line_num, index)
    local M = string.sub(table[line_num+1] or "", index-1, index-1)
    local A = string.sub(table[line_num+2] or "", index-2, index-2)
    local S = string.sub(table[line_num+3] or "", index-3, index-3)
    return M == "M" and A == "A" and S == "S"
end

---@param table table<integer, string>
---@param line_num integer
---@param index integer
---@return boolean
local function is_diagonal_up_right(table, line_num, index)
    local M = string.sub(table[line_num-1] or "", index+1, index+1)
    local A = string.sub(table[line_num-2] or "", index+2, index+2)
    local S = string.sub(table[line_num-3] or "", index+3, index+3)
    return M == "M" and A == "A" and S == "S"
end

---@param table table<integer, string>
---@param line_num integer
---@param index integer
---@return boolean
local function is_diagonal_up_left(table, line_num, index)
    local M = string.sub(table[line_num-1] or "", index-1, index-1)
    local A = string.sub(table[line_num-2] or "", index-2, index-2)
    local S = string.sub(table[line_num-3] or "", index-3, index-3)
    return M == "M" and A == "A" and S == "S"
end

local count = 0
for line_num, line in ipairs(word_search) do
    local index = 1
    local max_len = #line
    while index <= max_len do
        local x_idx = string.find(line, "X", index)
        if not x_idx then
            break
        end

        if is_horizontal(line, x_idx) then
            count = count + 1
        end
        if is_horizontal_backwards(line, x_idx) then
            count = count + 1
        end
        if is_vertical(word_search, line_num, x_idx) then
            count = count + 1
        end
        if is_vertical_backwards(word_search, line_num, x_idx) then
            count = count + 1
        end
        if is_diagonal_down_right(word_search, line_num, x_idx) then
            count = count + 1
        end
        if is_diagonal_down_left(word_search, line_num, x_idx) then
            count = count + 1
        end
        if is_diagonal_up_right(word_search, line_num, x_idx) then
            count = count + 1
        end
        if is_diagonal_up_left(word_search, line_num, x_idx) then
            count = count + 1
        end
        index = x_idx + 1
    end
end
print (count)
