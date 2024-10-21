-- local file = io.open("test_input_1.txt", "r")
local file = io.open("puzzle_input.txt", "r")
if not file then error("File not found") end

local schematic = {}
for line in file:lines() do
    table.insert(schematic, line)
end

local schematic_rows_count = #schematic
local sum = 0
for row = 1, schematic_rows_count do
    local row_above = nil
    local row_below = nil
    local current_row = schematic[row]
    if row == 1 then
        row_above = ''
        row_below = schematic[row + 1]
    elseif row == schematic_rows_count then
        row_above = schematic[row - 1]
        row_below = ''
    else
        row_above = schematic[row - 1]
        row_below = schematic[row + 1]
    end

    local min_column_idx = 1
    local max_column_idx = #current_row
    for part_number in string.gmatch(current_row, "%d+") do
        local start_digits_idx, end_digits_idx = string.find(current_row, part_number, min_column_idx)
        local start_idx = math.max(min_column_idx, start_digits_idx - 1)
        local end_idx = math.min(max_column_idx, end_digits_idx + 1)
        min_column_idx = end_idx -- do not search before this index

        local above = string.sub(row_above, start_idx, end_idx)
        local current = string.sub(current_row, start_idx, end_idx)
        local below = string.sub(row_below, start_idx, end_idx)
        local section = above .. current .. below
        local is_valid_part_number = string.find(section, "[^0-9.]") ~= nil
        if is_valid_part_number then
            sum = sum + tonumber(part_number, 10)
        end
    end
end
print(sum)
