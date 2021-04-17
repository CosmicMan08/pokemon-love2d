love.window.updateMode(640, 576)

function create_array_from_file(mapsplit, stringname)
	local levelarray = {}
	for i = 1, 1 do 
		line = string.gmatch(mapsplit, stringname)
		table.insert(levelarray, 1, line)
	end
	tileTable = levelarray
end

local player = {
	ypos = 5;
	xpos = 5;
	direction = "down";
	still = true;
	moving = false;
	walkcycleframe = 1;
	walkcycletime = 1;
	vertwalkframe = 1;
	horiwalkframe = 1
}
globalanimationframe = 1

collisionarray = {
	1,2,2,1,1,1,2,2
}

tileTable = {
  {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
  {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,2,3,3,3,3,3,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,2,6,6,6,6,3,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,2,6,6,6,6,3,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,2,5,2,3,3,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,2,1,1,4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,7,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
  {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2}
}

function checkForward()
	for i = 1, 1 do
		if entityTable[i]["entityType"] == "sign" then
			if player.direction == "up" and player.xpos == entityTable[i]["xPos"] and player.ypos - 1 == entityTable[i]["yPos"] then
				-- love.graphics.print(dialogueTable[entityTable[i]["dialoguePos"]][1], 400, 300)
				player.direction = "left"
				loadDialogue(dialogueTable[entityTable[i]["dialoguePos"]][1])
			end
		end
		i = i + 1
	end
end

function loadDialogue(dialogue)
	love.graphics.draw(uisheet, ui1, 1 * 32, 7 * 32, 0, 4, 4)
end

entityTable = {
	-- {"entityType", xPos, yPos, arg1... argEtc}
	{entityType = "sign", xPos = 12, yPos = 12, dialoguePos = 1}
}

dialogueTable = {
	{"laura is palm", "latin here"}
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
			end
		end
	end
end

function love.update(dt)
	if player.still == true then
		if love.keyboard.isDown("s") then
			if collisionarray[tileTable[player.ypos + 1][player.xpos]] == 1 then
				player.ypos = player.ypos + 1
				player.still = false
			end
			player.direction = "down"
			player.moving = true
		elseif love.keyboard.isDown('w') then
			if collisionarray[tileTable[player.ypos - 1][player.xpos]] == 1 then
				player.ypos = player.ypos - 1
				player.still = false
			end
			player.direction = "up"
			player.moving = true
		elseif love.keyboard.isDown('a') then
			if collisionarray[tileTable[player.ypos][player.xpos - 1]] == 1 then
				player.xpos = player.xpos - 1
				player.still = false
			end
			player.direction = "left"
			player.moving = true
		elseif love.keyboard.isDown("d") then
			if collisionarray[tileTable[player.ypos][player.xpos + 1]] == 1 then
				player.xpos = player.xpos + 1
				player.still = false
			end
			player.direction = "right"
			player.moving = true
		elseif love.keyboard.isDown("space") then
			checkForward()
		end
	end
	if globalanimationframe > 64 or globalanimationframe == 64 then
		globalanimationframe = 1
	else
		globalanimationframe = globalanimationframe + 1
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

function love.load()

sourcecode = love.filesystem.getSource()

testmap1 = love.filesystem.read(sourcecode .. "testmap1.txt")

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

	love.graphics.print(player.direction, 400, 300)
	love.graphics.print(globalanimationframe, 400, 200)
	if player.still == false then
		if player.direction == "down" then
			if player.walkcycleframe > 0 and player.walkcycleframe < 9 then
				love.graphics.draw(fredsheet, fredwalkingdown1, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
			end
			if player.walkcycleframe > 8 and player.walkcycleframe < 17 then
				love.graphics.draw(fredsheet, fredwalkingdown2, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
			end
			if player.walkcycleframe > 16 and player.walkcycleframe < 25 then
				love.graphics.draw(fredsheet, fredwalkingdown3, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
			end
			if player.walkcycleframe > 24 and player.walkcycleframe < 33 then
				love.graphics.draw(fredsheet, fredwalkingdown4, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
			end
		end
		if player.direction == "up" then
			if player.walkcycleframe > 0 and player.walkcycleframe < 9 then
				love.graphics.draw(fredsheet, fredwalkingup1, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
			end
			if player.walkcycleframe > 8 and player.walkcycleframe < 17 then
				love.graphics.draw(fredsheet, fredwalkingup2, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
			end
			if player.walkcycleframe > 16 and player.walkcycleframe < 25 then
				love.graphics.draw(fredsheet, fredwalkingup3, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
			end
			if player.walkcycleframe > 24 and player.walkcycleframe < 33 then
				love.graphics.draw(fredsheet, fredwalkingup4, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
			end
		end
		if player.direction == "left" then
			if player.walkcycleframe > 0 and player.walkcycleframe < 9 then
				love.graphics.draw(fredsheet, fredwalkingleft1, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
			end
			if player.walkcycleframe > 8 and player.walkcycleframe < 17 then
				love.graphics.draw(fredsheet, fredwalkingleft2, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
			end
			if player.walkcycleframe > 16 and player.walkcycleframe < 25 then
				love.graphics.draw(fredsheet, fredwalkingleft1, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
			end
			if player.walkcycleframe > 24 and player.walkcycleframe < 33 then
				love.graphics.draw(fredsheet, fredwalkingleft2, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
			end
		end
		if player.direction == "right" then
			if player.walkcycleframe > 0 and player.walkcycleframe < 9 then
				love.graphics.draw(fredsheet, fredwalkingright1, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
			end
			if player.walkcycleframe > 8 and player.walkcycleframe < 17 then
				love.graphics.draw(fredsheet, fredwalkingright2, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
			end
			if player.walkcycleframe > 16 and player.walkcycleframe < 25 then
				love.graphics.draw(fredsheet, fredwalkingright1, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
			end
			if player.walkcycleframe > 24 and player.walkcycleframe < 33 then
				love.graphics.draw(fredsheet, fredwalkingright2, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
			end 
		end
	else
		if player.direction == "down" then
			love.graphics.draw(fredsheet, fredwalkingdown1, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
		end
		if player.direction == "up" then
			love.graphics.draw(fredsheet, fredwalkingup1, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
		end
		if player.direction == "left" then
			love.graphics.draw(fredsheet, fredwalkingleft1, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
		end
		if player.direction == "right" then
			love.graphics.draw(fredsheet, fredwalkingright1, 5 * 64 - 64, 5 * 64 - 84, 0, 4, 4)
		end
	end
end