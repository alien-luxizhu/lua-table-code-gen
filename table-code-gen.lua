local space4 = string.rep(" ", 4)
local function code_gen(t, deps)
    local lines = {}
    if #t == 0 then
        for key, value in pairs(t) do
            local typ = type(value)
            if typ == "table" then
                value = code_gen(value, deps + 1)
            elseif typ == "string" then
                value = string.format("%q", value)
            end
            table.insert(lines, key .. " = " .. value)
        end
    else
        for _, value in ipairs(t) do
            local typ = type(value)
            if typ == "table" then
                value = code_gen(value, deps + 1)
            elseif typ == "string" then
                value = string.format("%q", value)
            end
            table.insert(lines, value)
        end
    end
    local indent = string.rep(space4, deps + 1)
    local sep = ",\n" .. indent
    return "{\n" .. indent .. table.concat(lines, sep) .. "\n" .. string.rep(space4, deps) .. "}"
end

local function table_code_gen(t)
    return code_gen(t, 0)
end
