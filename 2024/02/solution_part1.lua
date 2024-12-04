-- local file = io.open("test_input_1.txt", "r")
local file = io.open("puzzle_input.txt", "r")
if not file then error("File not found") end

local count = 0
for line in file:lines() do
    local safe = true

    local report = {}
    for value in string.gmatch(line, "%d+") do
        table.insert(report, tonumber(value, 10))
    end

    local min_level = 1
    local max_level = #report
    for index, current_level in ipairs(report) do
        local prev_level = nil
        local next_level = nil
        if index > min_level then
            prev_level = report[index - 1]
        end
        if index < max_level then
            next_level = report[index + 1]
        end

        if prev_level ~= nil then
            local difference = math.abs(current_level - prev_level)
            if difference < 1 or difference > 3 then
                safe = false
                break
            end
        end
        if next_level ~= nil then
            local difference = math.abs(current_level - next_level)
            if difference < 1 or difference > 3 then
                safe = false
                break
            end
        end

        if prev_level ~= nil and next_level ~= nil then
            local first = current_level - prev_level
            local second = next_level - current_level
            if first == 0 and second == 0 then
                safe = false
                break
            elseif (first > 0 and second < 0) or (first < 0 and second > 0) then
                safe = false
                break
            end
        end
    end

    if safe then
        count = count + 1
    end
end
file:close()
print(count)
