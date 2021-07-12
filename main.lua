love.window.setTitle("pokemon gb engine")
love.window.updateMode(640, 576)

function love.keypressed(key)
	if key == "space" then
		halfSpacePress = true
	else
		halfSpacePress = false
	end
end

function loadMapFromFile(loadedLevel)
	print(loadedLevel)
	local levelEnd = string.find(loadedLevel, "/")
	local commaPos = 0
	local commaEnd = 0
	local levelArray = {}
	local levelDecay = string.sub(loadedLevel, 1, levelEnd - 1)
	local newRow = {}
	print(string.sub(loadedLevel, 1, levelEnd - 1))
	print(newRow)
	local _,levelTiles = string.gsub(levelDecay,",",",")
	print(levelTiles)
	local _,levelRows = string.gsub(levelDecay,"*","*")
	print(levelRows)
	local levelColumns = levelTiles / levelRows
	print(levelColumns)
	for v = 1, levelRows do 
		for k = 1, levelColumns do 
			if commaPos == nil then
				commaPos = 0
			end
			newTile = tonumber(string.sub(levelDecay, 1, commaPos - 1))
			levelDecay = string.sub(levelDecay, string.find(levelDecay, ",") + 1, string.len(levelDecay))
			commaPos = string.find(levelDecay, ",")
			table.insert(newRow, newTile)
			--print(commaPos)
			--print(commaEnd)
			--print(levelDecay)
			print(newTile)
			--print(newRow)
		end
		table.insert(levelArray, newRow)
		newRow = {}
	end
	tileTable = levelArray
	print(tileTable)

	-- entity loading!

	local entityList = string.sub(loadedLevel, string.find(loadedLevel, "/") + 1, string.find(loadedLevel, "^") - 1)
end

halfSpacePress = false
textPosition = 1
currentTextLength = 0
renderedDialogue = ""
timerThingy = -3
gameFreeze = false
veryHiddenDebugMode = false

local player = {
	ypos = 1;
	xpos = 1;
	direction = "up";
	still = true;
	moving = false;
	walkcycleframe = 1;
	walkcycletime = 1;
	vertwalkframe = 1;
	horiwalkframe = 1
}
globalAnimationFrame = 1

collisionarray = {
	1,2,2,1,1,1,2,2,1,1,3
}

function teleportClick()
	return;
end

tileTable = {
	{02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02},
	{02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02},
	{01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,01,02,02,02,02,02,02,02,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,01,02,03,03,03,03,03,02,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,01,02,06,06,06,06,03,02,01,01,10,01,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,01,02,06,06,06,06,03,02,01,01,11,01,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,01,02,05,02,03,03,02,02,01,10,01,10,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,02,01,01,04,01,01,01,01,01,01,11,01,11,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,08,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,07,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,09,09,09,09,09,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,09,09,09,09,09,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,09,09,09,09,09,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,09,09,09,09,09,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,09,09,09,09,09,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01},
	{01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01,01},
	{02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02},
	{02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02,02}
}

function drawFred()
	if player.still == false then
		if player.direction == "down" then
			if player.walkcycleframe > 0 and player.walkcycleframe < 9 then
				love.graphics.draw(fredsheet, fredwalkingdown1, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
			end
			if player.walkcycleframe > 8 and player.walkcycleframe < 17 then
				love.graphics.draw(fredsheet, fredwalkingdown2, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
			end
			if player.walkcycleframe > 16 and player.walkcycleframe < 25 then
				love.graphics.draw(fredsheet, fredwalkingdown3, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
			end
			if player.walkcycleframe > 24 and player.walkcycleframe < 33 then
				love.graphics.draw(fredsheet, fredwalkingdown4, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
			end
		end
		if player.direction == "up" then
			if player.walkcycleframe > 0 and player.walkcycleframe < 9 then
				love.graphics.draw(fredsheet, fredwalkingup1, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
			end
			if player.walkcycleframe > 8 and player.walkcycleframe < 17 then
				love.graphics.draw(fredsheet, fredwalkingup2, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
			end
			if player.walkcycleframe > 16 and player.walkcycleframe < 25 then
				love.graphics.draw(fredsheet, fredwalkingup3, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
			end
			if player.walkcycleframe > 24 and player.walkcycleframe < 33 then
				love.graphics.draw(fredsheet, fredwalkingup4, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
			end
		end
		if player.direction == "left" then
			if player.walkcycleframe > 0 and player.walkcycleframe < 9 then
				love.graphics.draw(fredsheet, fredwalkingleft1, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
			end
			if player.walkcycleframe > 8 and player.walkcycleframe < 17 then
				love.graphics.draw(fredsheet, fredwalkingleft2, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
			end
			if player.walkcycleframe > 16 and player.walkcycleframe < 25 then
				love.graphics.draw(fredsheet, fredwalkingleft1, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
			end
			if player.walkcycleframe > 24 and player.walkcycleframe < 33 then
				love.graphics.draw(fredsheet, fredwalkingleft2, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
			end
		end
		if player.direction == "right" then
			if player.walkcycleframe > 0 and player.walkcycleframe < 9 then
				love.graphics.draw(fredsheet, fredwalkingright1, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
			end
			if player.walkcycleframe > 8 and player.walkcycleframe < 17 then
				love.graphics.draw(fredsheet, fredwalkingright2, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
			end
			if player.walkcycleframe > 16 and player.walkcycleframe < 25 then
				love.graphics.draw(fredsheet, fredwalkingright1, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
			end
			if player.walkcycleframe > 24 and player.walkcycleframe < 33 then
				love.graphics.draw(fredsheet, fredwalkingright2, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
			end 
		end
	else
		if player.direction == "down" then
			love.graphics.draw(fredsheet, fredwalkingdown1, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
		end
		if player.direction == "up" then
			love.graphics.draw(fredsheet, fredwalkingup1, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
		end
		if player.direction == "left" then
			love.graphics.draw(fredsheet, fredwalkingleft1, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
		end
		if player.direction == "right" then
			love.graphics.draw(fredsheet, fredwalkingright1, 5 * 64 - 64, 5 * 64 - 80, 0, 4, 4)
		end
	end
end

function checkForward()
	for i, v in ipairs(entityTable) do
		if v["entityType"] == "sign" then
			if player.direction == "up" and player.xpos == v["xPos"] and player.ypos - 1 == v["yPos"] then
				currentDialogue = dialogueTable[v["dialoguePos"]][1]
			end
		end
	end
end

function drawDialogue(dialogue)
	if currentDialogue ~= nil then
		gameFreeze = true
		-- line 1
		love.graphics.draw(uisheet, ui1, 0 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 1 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 2 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 3 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 4 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 5 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 6 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 7 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 8 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 9 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 10 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 11 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 12 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 13 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 14 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 15 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 16 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 17 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 18 * 32, 12 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui4, 19 * 32, 12 * 32, 0, 4, 4)
		-- line 2
		love.graphics.draw(uisheet, ui6, 0 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 1 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 2 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 3 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 4 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 5 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 6 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 7 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 8 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 9 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 10 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 11 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 12 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 13 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 14 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 15 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 16 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 17 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 18 * 32, 13 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui6, 19 * 32, 13 * 32, 0, 4, 4)
		-- line 3
		love.graphics.draw(uisheet, ui6, 0 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 1 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 2 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 3 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 4 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 5 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 6 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 7 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 8 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 9 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 10 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 11 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 12 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 13 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 14 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 15 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 16 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 17 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 18 * 32, 14 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui6, 19 * 32, 14 * 32, 0, 4, 4)
		-- line 4
		love.graphics.draw(uisheet, ui6, 0 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 1 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 2 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 3 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 4 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 5 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 6 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 7 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 8 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 9 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 10 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 11 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 12 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 13 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 14 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 15 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 16 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 17 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 18 * 32, 15 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui6, 19 * 32, 15 * 32, 0, 4, 4)
		-- line 5
		love.graphics.draw(uisheet, ui6, 0 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 1 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 2 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 3 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 4 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 5 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 6 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 7 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 8 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 9 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 10 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 11 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 12 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 13 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 14 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 15 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 16 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 17 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui7, 18 * 32, 16 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui6, 19 * 32, 16 * 32, 0, 4, 4)
		-- line 6
		love.graphics.draw(uisheet, ui3, 0 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 1 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 2 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 3 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 4 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 5 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 6 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 7 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 8 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 9 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 10 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 11 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 12 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 13 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 14 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 15 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 16 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 17 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui5, 18 * 32, 17 * 32, 0, 4, 4)
		love.graphics.draw(uisheet, ui2, 19 * 32, 17 * 32, 0, 4, 4)
		
		renderedDialogue = string.sub(currentDialogue, 1, currentTextLength)
		love.graphics.print({{0, 0, 0}, renderedDialogue}, 1 * 32, 14 * 32)
		if string.len(renderedDialogue) == string.len(currentDialogue) then
			--if halfSpacePress == true then
			if love.keyboard.isDown("space") then
				textPosition = 1
				currentTextLength = 0
				timerThingy = -3
				currentDialogue = nil
				renderedDialogue = ""
				gameFreeze = false
			end
		elseif string.len(renderedDialogue) < string.len(currentDialogue) then
			timerThingy = timerThingy + 1
			if timerThingy >= 4 then
				currentTextLength = currentTextLength + 1
				renderedDialogue = string.sub(currentDialogue, 1, currentTextLength)
				timerThingy = 1
			end
			love.graphics.print({{0, 0, 0}, renderedDialogue}, 1 * 32, 14 * 32)
			print(renderedDialogue)
		end
	end
end

entityTable = {
}

dialogueTable = {
}

entityTable = {
	-- {"entityType", xPos, yPos, arg1... argEtc}
	{entityType = "sign", xPos = 11, yPos = 12, dialoguePos = 1},
	{entityType = "sign", xPos = 12, yPos = 15, dialoguePos = 2}
}

dialogueTable = {
	{"laura is palm \n \nlatin here "},
	{"yo mari0 amirite \n \nanyway time to do magic "}
}

function drawTiles(world)
	for ykey, v in ipairs(tileTable) do
		for xkey, b in ipairs(v) do
			if tileTable[ykey][xkey] ~= 0 then
				if tileTable[ykey][xkey] == 1 then
					love.graphics.draw(tilesheet, tile1, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, 4, 4)
				end
				if tileTable[ykey][xkey] == 2 then
					love.graphics.draw(tilesheet, tile2, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, 4, 4)
				end
				if tileTable[ykey][xkey] == 3 then
					love.graphics.draw(tilesheet, tile3, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, 4, 4)
				end
				if tileTable[ykey][xkey] == 4 then
					love.graphics.draw(tilesheet, tile4, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, 4, 4)
				end
				if tileTable[ykey][xkey] == 5 then
					love.graphics.draw(tilesheet, tile5, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, 4, 4)
				end
				if tileTable[ykey][xkey] == 6 then
					love.graphics.draw(tilesheet, tile6, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, 4, 4)
				end
				if tileTable[ykey][xkey] == 7 then
					love.graphics.draw(tilesheet, tile7, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, 4, 4)
				end
				if tileTable[ykey][xkey] == 8 then
					love.graphics.draw(tilesheet, tile8, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, 4, 4)
				end
				if tileTable[ykey][xkey] == 9 then
					love.graphics.draw(tilesheet, tile1, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, 4, 4)
				end
				if tileTable[ykey][xkey] == 10 then
					love.graphics.draw(tilesheet, tile1, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, 4, 4)
				end
				if tileTable[ykey][xkey] == 11 then
					love.graphics.draw(tilesheet, tile1, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, 4, 4)
				end
			end
		end
	end
end

function drawForegroundTiles(world)
	for ykey, v in ipairs(tileTable) do
		for xkey, b in ipairs(v) do
			if tileTable[ykey][xkey] ~= 0 then
				if tileTable[ykey][xkey] == 9 then
					love.graphics.draw(tilesheet, tile9, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, 4, 4)
				end
				if tileTable[ykey][xkey] == 10 then
					if globalAnimationFrame > 0 and globalAnimationFrame < 9 then
						love.graphics.draw(tilesheet, tile10, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, 4, 4)
					elseif globalAnimationFrame > 8 and globalAnimationFrame < 17 then
						love.graphics.draw(tilesheet, tile11, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, 4, 4)
					elseif globalAnimationFrame > 16 and globalAnimationFrame < 25 then
						love.graphics.draw(tilesheet, tile10, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64 + 64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, -4, 4)
					elseif globalAnimationFrame > 24 and globalAnimationFrame < 33 then
						love.graphics.draw(tilesheet, tile11, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64 + 64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, -4, 4)
					end
				end
				if tileTable[ykey][xkey] == 11 then
					if globalAnimationFrame > 0 and globalAnimationFrame < 9 then
						love.graphics.draw(tilesheet, tile13, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, 4, 4)
					elseif globalAnimationFrame > 8 and globalAnimationFrame < 17 then
						love.graphics.draw(tilesheet, tile14, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, 4, 4)
					elseif globalAnimationFrame > 16 and globalAnimationFrame < 25 then
						love.graphics.draw(tilesheet, tile13, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64 + 64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, -4, 4)
					elseif globalAnimationFrame > 24 and globalAnimationFrame < 33 then
						love.graphics.draw(tilesheet, tile14, (xkey * 64 + 256 + (player.horiwalkframe * 4)) + player.xpos * -64 + 64, (ykey * 64 + 256 + (player.vertwalkframe * 4)) + player.ypos * -64, 0, -4, 4)
					end
				end
			end
		end
	end
end

function love.update(dt)
	if gameFreeze == false then
		if player.still == true then
			if love.keyboard.isDown("s") then
				if collisionarray[tileTable[player.ypos + 1][player.xpos]] ~= 2 then
					player.ypos = player.ypos + 1
					player.still = false
				end
				player.direction = "down"
				player.moving = true
			elseif love.keyboard.isDown('w') then
				if collisionarray[tileTable[player.ypos - 1][player.xpos]] ~= 2 then
					player.ypos = player.ypos - 1
					player.still = false
				end
				player.direction = "up"
				player.moving = true
			elseif love.keyboard.isDown('a') then
				if collisionarray[tileTable[player.ypos][player.xpos - 1]] ~= 2 then
					player.xpos = player.xpos - 1
					player.still = false
				end
				player.direction = "left"
				player.moving = true
			elseif love.keyboard.isDown("d") then
				if collisionarray[tileTable[player.ypos][player.xpos + 1]] ~= 2 then
					player.xpos = player.xpos + 1
					player.still = false
				end
				player.direction = "right"
				player.moving = true
			elseif love.keyboard.isDown("space") then
				checkForward()
			end
		end
		if player.still == false then
			if player.walkcycleframe > 32 or player.walkcycleframe == 32 then
				player.walkcycleframe = 1
			else
				player.walkcycleframe = player.walkcycleframe + 1
			end
			if player.walkcycletime > 16 or player.walkcycletime == 16 then
				player.walkcycletime = 1
				player.vertwalkframe = 0
				player.horiwalkframe = 0
				player.still = true
				player.moving = false
				if collisionarray[tileTable[player.ypos][player.xpos]] == 3 and player.direction == "right" then
					player.horiwalkframe = player.walkcycletime - 16
					player.direction = "left"
					player.moving = true
					player.xpos = player.xpos - 1
					player.still = false
				elseif collisionarray[tileTable[player.ypos][player.xpos]] == 3 and player.direction == "left" then
					player.horiwalkframe = player.walkcycletime * -1 + 15
					player.direction = "right"
					player.moving = true
					player.xpos = player.xpos + 1
					player.still = false
				elseif collisionarray[tileTable[player.ypos][player.xpos]] == 3 and player.direction == "up" then
					player.vertwalkframe = player.walkcycletime * -1 + 15
					player.direction = "down"
					player.moving = true
					player.ypos = player.ypos + 1
					player.still = false
				elseif collisionarray[tileTable[player.ypos][player.xpos]] == 3 and player.direction == "down" then
					player.vertwalkframe = player.walkcycletime - 16
					player.direction = "up"
					player.moving = true
					player.ypos = player.ypos - 1
					player.still = false
				end
			else
				if player.direction == "up" then
					player.vertwalkframe = player.walkcycletime - 16
				end
				if player.direction == "right" then
					player.horiwalkframe = player.walkcycletime * -1 + 15
				end
				if player.direction == "down" then
					player.vertwalkframe = player.walkcycletime * -1 + 15
				end
				if player.direction == "left" then
					player.horiwalkframe = player.walkcycletime - 16
				end
				player.walkcycletime = player.walkcycletime + 1
			end
		end
	end
	if veryHiddenDebugMode == true then
		teleportClick()
	end
	if globalAnimationFrame > 32 or globalAnimationFrame == 32 then
		globalAnimationFrame = 1
	else
		globalAnimationFrame = globalAnimationFrame + 1
	end
end

function love.load()

pokemonFont = love.graphics.newFont("PokemonFont.ttf", 32, "mono", love.graphics.getDPIScale())

love.graphics.setFont(pokemonFont)

testmap1 = love.filesystem.read("testmap1.txt")
print(testmap1)
loadMapFromFile(testmap1)

-- create_array_from_file("testmap1.txt", "/n")

love.graphics.setDefaultFilter("nearest")

tilesheet = love.graphics.newImage("tilesheet.png")
tile1 = love.graphics.newQuad(0, 0, 16, 16, tilesheet)
tile2 = love.graphics.newQuad(16, 0, 16, 16, tilesheet)
tile3 = love.graphics.newQuad(32, 0, 16, 16, tilesheet)
tile4 = love.graphics.newQuad(0, 16, 16, 16, tilesheet)
tile5 = love.graphics.newQuad(16, 16, 16, 16, tilesheet)
tile6 = love.graphics.newQuad(32, 16, 16, 16, tilesheet)
tile7 = love.graphics.newQuad(0, 32, 16, 16, tilesheet)
tile8 = love.graphics.newQuad(16, 32, 16, 16, tilesheet)
tile9 = love.graphics.newQuad(32, 32, 16, 16, tilesheet)
tile10 = love.graphics.newQuad(0, 48, 16, 16, tilesheet)
tile11 = love.graphics.newQuad(16, 48, 16, 16, tilesheet)
tile12 = love.graphics.newQuad(32, 48, 16, 16, tilesheet)
tile13 = love.graphics.newQuad(0, 64, 16, 16, tilesheet)
tile14 = love.graphics.newQuad(16, 64, 16, 16, tilesheet)
tile15 = love.graphics.newQuad(32, 64, 16, 16, tilesheet)

uisheet = love.graphics.newImage("uisheet.png")
ui1 = love.graphics.newQuad(0, 0, 8, 8, uisheet)
ui2 = love.graphics.newQuad(8, 0, 8, 8, uisheet)
ui3 = love.graphics.newQuad(16, 0, 8, 8, uisheet)
ui4 = love.graphics.newQuad(24, 0, 8, 8, uisheet)
ui5 = love.graphics.newQuad(32, 0, 8, 8, uisheet)
ui6 = love.graphics.newQuad(40, 0, 8, 8, uisheet)
ui7 = love.graphics.newQuad(0, 8, 8, 8, uisheet)

fredsheet = love.graphics.newImage("fredsheet.png")
fredwalkingdown1 = love.graphics.newQuad(0, 0, 16, 16, fredsheet)
fredwalkingdown2 = love.graphics.newQuad(16, 0, 16, 16, fredsheet)
fredwalkingdown3 = love.graphics.newQuad(32, 0, 16, 16, fredsheet)
fredwalkingdown4 = love.graphics.newQuad(48, 0, 16, 16, fredsheet)
fredwalkingup1 = love.graphics.newQuad(64, 0, 16, 16, fredsheet)
fredwalkingup2 = love.graphics.newQuad(80, 0, 16, 16, fredsheet)
fredwalkingup3 = love.graphics.newQuad(96, 0, 16, 16, fredsheet)
fredwalkingup4 = love.graphics.newQuad(112, 0, 16, 16, fredsheet)
fredwalkingleft1 = love.graphics.newQuad(128, 0, 16, 16, fredsheet)
fredwalkingleft2 = love.graphics.newQuad(144, 0, 16, 16, fredsheet)
fredwalkingright1 = love.graphics.newQuad(160, 0, 16, 16, fredsheet)
fredwalkingright2 = love.graphics.newQuad(176, 0, 16, 16, fredsheet)
end

function love.draw()
	drawTiles()
	
	--love.graphics.print(player.direction, 400, 300)
	--love.graphics.print(globalAnimationFrame, 400, 200)
	
	drawFred()

	drawForegroundTiles()

	love.graphics.setScissor(5 * 64 - 64, 5 * 64 - 80, 64, 32)
	drawFred()
	love.graphics.setScissor()

	drawDialogue(currentDialogue)
end