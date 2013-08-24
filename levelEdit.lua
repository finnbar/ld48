levelEdit = {}

function levelEdit.draw()
	for x=1,w,1 do
		for y=1,h,1 do
			if tiles[x][y] ~= 0 then
				love.graphics.draw(tileRef[tiles[x][y]],(x-1)*box,(y-1)*box)
				if tiles[x][y] ~= playerNo then  --not PLAYER!!!
					if x<w then
						if tiles[x+1][y] ~= 0 and tiles[x+1][y] ~= playerNo then
							love.graphics.draw(tileRef[tiles[x][y]+1],((x-1)*box)+hBox,(y-1)*box)
						end
					end
					if x>1 then
						if tiles[x-1][y] ~= 0 and tiles[x-1][y] ~= playerNo then
							love.graphics.draw(tileRef[tiles[x][y]+1],((x-1)*box)-hBox,(y-1)*box)
						end
					end
					if y<h then
						if tiles[x][y+1] ~= 0 and tiles[x][y+1] ~= playerNo then
							love.graphics.draw(tileRef[tiles[x][y]+2],(x-1)*box,((y-1)*box)+hBox)
						end
					end
					if y>1 then
						if tiles[x][y-1] ~= 0 and tiles[x][y-1] ~= playerNo then
							love.graphics.draw(tileRef[tiles[x][y]+2],(x-1)*box,((y-1)*box)-hBox)
						end
					end
					if x<w and y<h  then
						local good = true
						local things = {tiles[x][y+1],tiles[x+1][y],tiles[x+1],tiles[y+1]}
						for th=1,#things,1 do
							if things[th] == 0 or things[th] == playerNo then
								good = false
							end
						end
						if good then
							--print("good")
							love.graphics.draw(tileRef[tiles[x][y]+3],((x-1)*box)+hBox,((y-1)*box)+hBox)
						end
					end
				end
			end
		end
	end
	local xPos = math.ceil(love.mouse.getX()/box)
	local yPos = math.ceil(love.mouse.getY()/box)
	local thisX = ((xPos-1)*box)+qBox
	local thisY = ((yPos-1)*box)+qBox
	love.graphics.polygon("fill",thisX,thisY,thisX+hBox,thisY,thisX+hBox,thisY+hBox,thisX,thisY+hBox)
end

function levelEdit.update()
	--NOTHING!!!!
end

function levelEdit.mousepressed(x,y,button)
	local xPos = math.ceil(x/box)
	local yPos = math.ceil(y/box)
	if button == "l" then
		tiles[xPos][yPos] = 1
	elseif button == "r" then
		tiles[xPos][yPos] = 0
	elseif button == "m" then
		tiles[xPos][yPos] = playerNo
	end
end

function levelEdit.keypressed(key,unicode)
	if key == "s" then
		local levelData = "level = {"
		for x=1,w,1 do
			levelData = levelData .. "{"
			for y=1,h,1 do
				levelData = levelData .. tiles[x][y]
				if h-y~=0 then
					levelData = levelData .. ","
				end
			end
			levelData = levelData .. "}"
			if w-x~=0 then
				levelData = levelData .. ","
			end
		end
		levelData = levelData .. "}"
		print(love.filesystem.write("levels.lua",levelData,all))
	end
	if key == "l" then
		tiles = level
	end
	if key == "x" then
		gamestate = menu
	end
end