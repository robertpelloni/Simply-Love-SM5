local characters = LoadActor("Characters.lua")
local gridWidth = 10

local af = Def.ActorFrame {}

for i, char in ipairs(characters) do
	local col = (i - 1) % gridWidth
	local row = math.floor((i - 1) / gridWidth)

	af[#af+1] = LoadFont("Common Normal").. {
		Name=char,
		Text=char,
		InitCommand=function(self)
			self:xy(col * 30 - 135, row * 30 - 30)
			self:zoom(0.8)
		end,
		GainFocusCommand=function(self)
			self:diffuse(color("1,0.5,0.5,1"))
		end,
		LoseFocusCommand=function(self)
			self:diffuse(Color.White)
		end
	}
end

return af
