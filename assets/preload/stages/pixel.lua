function onCreate()
	-- background shit
	makeLuaSprite('gh', 'stages/pixel/gg', 300, 400);
	setScrollFactor('gh', 1, 1);
	setProperty('gh.antialiasing', false);
	addLuaSprite('gh', false);

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end