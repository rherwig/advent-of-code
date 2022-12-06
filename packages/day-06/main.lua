function get_file_contents(file)
    local lines = {};

    for line in io.lines(file) do
        lines[#lines + 1] = line;
    end

    return lines;
end

function is_message_prefix(line)
    local uniqueChars = {};

    for i = 1, #line do
        local currentChar = line:sub(i, i);

        if uniqueChars[currentChar] then
            return false;
        end

        uniqueChars[currentChar] = true;
    end

    return true;
end

function parse(line, targetLength, startIndex)
    targetLength = targetLength or 4;
    startIndex = startIndex or 1;

    local currentSequence = line:sub(startIndex, math.min(startIndex + targetLength - 1, #line));
    if #currentSequence ~= targetLength then
        return -1;
    end

    if is_message_prefix(currentSequence) then
        return (startIndex + targetLength) - 1;
    else
        return parse(line, targetLength, startIndex + 1);
    end
end

function task(targetLength)
    local input = get_file_contents('./resources/input.txt');

    for _, line in pairs(input) do
        local result = parse(line, targetLength);
        print("Result: " .. result);
    end
end

task(4);
task(14);
