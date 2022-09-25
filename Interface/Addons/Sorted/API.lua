local _, S = ...
Sorted = {}

-- Takes a key from the table at:
-- https://docs.google.com/spreadsheets/d/17eIDO0UU86-DUYjvu_ZyJ_9b8kMA9kTbAMDiQ0elXQA/edit?usp=sharing
-- and returns the translated string for the client's language.
-- Additional arguments will replace occurrences of "%s" in the returned string.
function Sorted.Localize(key, ...)
    return S.Localize(key, ...)
end

-- Returns whether or not Sorted is using the ElvUI skin
function Sorted.IsSkinned()
    return S.DoSkinning()
end

function Sorted.IsCurrentPlayerSelected()
    return S.IsCurrentPlayerSelected()
end