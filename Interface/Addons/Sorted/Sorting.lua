local _, S = ...
local pairs, ipairs, string, type, time = pairs, ipairs, string, type, time

S.Sort = {}

-- Sorts two entries by their supplied values, if they are identical then they are sorted by their second values
-- If inverse is 'true' then the keys are sorted ascending instead of descending
function S.Sort.ByTwoValues(inverse, value11, value21, value12, value22, entry1, entry2, DefaultFunc)
    if not value11 then
        return false
    elseif not value21 then
        return true
    end
    if value11 == value21 then
        if not value12 then
            return false
        elseif not value22 then
            return true
        end
        if value12 == value22 then
            return DefaultFunc(entry1, entry2) -- Both are identical, resort to a default sorting method
        end
        if not inverse then
            return value12 < value22
        else
            return value12 > value22
        end
    end
    if not inverse then
        return value11 < value21
    else
        return value11 > value21
    end
end

-- Sorts two entries by their 'key1', if they are identical then they are sorted by their 'key2'
-- If inverse is 'true' then the keys are sorted ascending instead of descending
function S.Sort.ByTwoKeys(inverse, entry1, entry2, key1, key2, DefaultFunc)
    return S.Sort.ByTwoValues(inverse, entry1[key1], entry2[key1], entry1[key2], entry2[key2], entry1, entry2, DefaultFunc)
end

-- Sorts two entries by two supplied values, resorting to DefaultSort if they are identical
-- If inverse is 'true' then the keys are sorted ascending instead of descending
function S.Sort.ByValue(inverse, value1, value2, entry1, entry2, DefaultFunc)
    if not value1 then
        return false
    elseif not value2 then
        return true
    end
    if value1 == value2 then
        return DefaultFunc(entry1, entry2) -- Both are identical, resort to a default sorting method
    end
    if not inverse then
        return value1 < value2
    else
        return value1 > value2
    end
end

-- Sorts two entries by their 'key', resorting to DefaultSort if they are identical
-- If inverse is 'true' then the keys are sorted ascending instead of descending
function S.Sort.ByKey(inverse, entry1, entry2, key, DefaultFunc)
    return S.Sort.ByValue(inverse, entry1[key], entry2[key], entry1, entry2, DefaultFunc)
end