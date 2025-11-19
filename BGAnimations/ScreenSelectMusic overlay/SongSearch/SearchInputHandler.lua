local searchQuery = ""
local selectedX = 0
local selectedY = 0
local characters = LoadActor("Characters.lua")
local gridWidth = 10
local gridHeight = math.ceil(#characters / gridWidth)

local function update_focus()
	local grid = SCREENMAN:GetTopScreen():GetChild("Overlay"):GetChild("SongSearch"):GetChild("SearchInput"):GetChild("CharacterGrid")
	for i, child in ipairs(grid:GetChildren()) do
		local col = (i - 1) % gridWidth
		local row = math.floor((i - 1) / gridWidth)
		if col == selectedX and row == selectedY then
			child:playcommand("GainFocus")
		else
			child:playcommand("LoseFocus")
		end
	end
end

local input = function(event)
	if event.type ~= "InputEventType_Press" then return false end

	local button = event.GameButton
	if button == "MenuRight" then
		selectedX = (selectedX + 1) % gridWidth
	elseif button == "MenuLeft" then
		selectedX = (selectedX - 1 + gridWidth) % gridWidth
	elseif button == "MenuDown" then
		selectedY = (selectedY + 1) % gridHeight
	elseif button == "MenuUp" then
		selectedY = (selectedY - 1 + gridHeight) % gridHeight
	elseif button == "Start" then
		local index = selectedY * gridWidth + selectedX
		if index < #characters then
			local char = characters[index + 1]
			if char == "<" then
				searchQuery = string.sub(searchQuery, 1, -2)
			elseif char == "OK" then
				MESSAGEMAN:Broadcast("PerformSearch", {query=searchQuery})
				SCREENMAN:GetTopScreen():GetChild("Overlay"):GetChild("SongSearch"):GetChild("SearchInput"):visible(false)
				SCREENMAN:GetTopScreen():RemoveInputCallback(input)
			else
				searchQuery = searchQuery .. char
			end
		end
		SCREENMAN:GetTopScreen():GetChild("Overlay"):GetChild("SongSearch"):GetChild("SearchInput"):GetChild("SearchQuery"):settext(searchQuery)
	elseif button == "Back" then
		SCREENMAN:GetTopScreen():GetChild("Overlay"):GetChild("SongSearch"):GetChild("SearchInput"):visible(false)
		SCREENMAN:GetTopScreen():RemoveInputCallback(input)
	end

	update_focus()
	return true
end

return input
