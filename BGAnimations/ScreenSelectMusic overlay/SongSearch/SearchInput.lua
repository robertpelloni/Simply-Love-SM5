local af = Def.ActorFrame {}

-- slightly darken the entire screen
af[#af+1] = Def.Quad {
	InitCommand=function(self)
		self:FullScreen():diffuse(Color.Black):diffusealpha(0.8)
	end
}

-- Main overlay
af[#af+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:xy(_screen.cx, _screen.cy)
	end,

	-- White border
	Def.Quad {
		InitCommand=function(self)
			self:diffuse(Color.White)
			self:zoomto(340, 200)
		end,
	},

	-- Main black body
	Def.Quad {
		InitCommand=function(self)
			self:diffuse(Color.Black)
			self:zoomto(338, 198)
		end,
	},

	-- Search query display
	LoadFont("Common Normal").. {
		Name="SearchQuery",
		InitCommand=function(self)
			self:y(-80)
			self:settext("")
		end,
	},

	-- Character grid
	LoadActor("CharacterGrid.lua")..{
		Name="CharacterGrid",
		InitCommand=function(self)
			self:y(20)
			self:GetChild("A"):playcommand("GainFocus")
		end,
	}
}

return af
