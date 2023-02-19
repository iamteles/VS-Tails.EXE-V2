function onCreate()
	-- background shit
	makeLuaSprite('sky', 'stages/yeold/SKY', -600, -100);
	setScrollFactor('sky', 0.9, 0.9);
	
	makeLuaSprite('floor1', 'stages/yeold/FLOOR2', -650, 0);
	setScrollFactor('floor1', 0.9, 0.9);
	scaleObject('floor1', 1.1, 1.1);

	makeLuaSprite('floor2', 'stages/yeold/FLOOR1', -650, 0);
	setScrollFactor('floor2', 0.9, 0.9);
	scaleObject('floor2', 1.1, 1.1);

	makeLuaSprite('grass', 'stages/yeold/frontgrass', -650, 0);
	setScrollFactor('grass', 0.9, 0.9);
	scaleObject('grass', 1.1, 1.1);

	addLuaSprite('sky', false);
	addLuaSprite('floor1', false);
	addLuaSprite('floor2', false);
	addLuaSprite('grass', false);

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end