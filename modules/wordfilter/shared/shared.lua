local badWords = Config.BadWords or {}

function WordFilter(name)
	if not name:match("^[%a]+$") then return true end
	for _, word in ipairs(badWords) do
		if name:lower():find(word) then return true end
	end
	return false
end