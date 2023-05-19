function onCreate()
	-- background shit
	makeLuaSprite('hall', 'stages/hall/hall', -500, -400);
	setScrollFactor('hall', 1, 1);
	scaleObject('hall', 1.7, 1.7);

	addLuaSprite('hall', false);

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end