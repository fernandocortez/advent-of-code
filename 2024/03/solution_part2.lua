-- local file = io.open("test_input_2.txt", "r")
local file = io.open("puzzle_input.txt", "r")
if not file then error("File not found") end

local enabled = true
local sum = 0
for line in file:lines() do
    local max_len = string.len(line)
    local index = 1

    while index < max_len do
        if not enabled then
            local start_idx, end_idx = string.find(line, "do%(%)", index)
            if start_idx then
                enabled = true
                index = end_idx + 1
            else
                break
            end
        else
            local disable_start_idx, disable_end_idx = string.find(line, "don't%(%)", index)
            local mul_start_idx, mul_end_idx = string.find(line, "mul%(%d%d?%d?,%d%d?%d?%)", index)
    
            if mul_start_idx and (disable_start_idx == nil or mul_start_idx < disable_start_idx) then
                local a, b = string.match(line, "mul%((%d+),(%d+)%)", mul_start_idx)
                sum = sum + (tonumber(a) * tonumber(b))
                index = mul_end_idx + 1
            elseif disable_start_idx then
                enabled = false
                index = disable_end_idx + 1
            else
                break
            end
        end
    end
end
file:close()
print(sum)
