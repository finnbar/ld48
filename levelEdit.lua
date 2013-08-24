levelEdit = {}
blockToPlace = 2

function levelEdit.draw()
	for x=1,w,1 do
		for y=1,h,1 do
			if tiles[x][y] ~= 0 then
				love.graphics.draw(tileRef[tiles[x][y]],(x-1)*box,(y-1)*box)
				if checkIt(tiles[x][y]) then  --not PLAYER!!!
					if x<w then
						if checkIt(tiles[x+1][y]) then
							love.graphics.draw(tileRef[3],((x-1)*box)+hBox,(y-1)*box)
						end
					end
					if x>1 then
						if checkIt(tiles[x-1][y]) then
							love.graphics.draw(tileRef[3],((x-1)*box)-hBox,(y-1)*box)
						end
					end
					if y<h then
						if checkIt(tiles[x][y+1]) then
							love.graphics.draw(tileRef[4],(x-1)*box,((y-1)*box)+hBox)
						end
					end
					if y>1 then
						if checkIt(tiles[x][y-1]) then
							love.graphics.draw(tileRef[4],(x-1)*box,((y-1)*box)-hBox)
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
							love.graphics.draw(tileRef[5],((x-1)*box)+hBox,((y-1)*box)+hBox)
						end
					end
				end
				if tiles[x][y] == 7 then
					if x<w then
						if tiles[x+1][y] == 2 or tiles[x+1][y] == 7 then
							love.graphics.draw(tileRef[3],((x-1)*box)+hBox,(y-1)*box)
						end
					end
					if y<h then
						if tiles[x][y+1] == 2 or tiles[x][y+1] == 7 then
							love.graphics.draw(tileRef[4],(x-1)*box,((y-1)*box)+hBox)
						end
					end
				end
				if checkIt2(tiles[x][y]) then  --not PLAYER!!!
					if x<w then
						if checkIt2(tiles[x+1][y]) then
							love.graphics.draw(tileRef[10],((x-1)*box)+hBox,(y-1)*box)
						end
					end
					if x>1 then
						if checkIt2(tiles[x-1][y]) then
							love.graphics.draw(tileRef[10],((x-1)*box)-hBox,(y-1)*box)
						end
					end
					if y<h then
						if checkIt2(tiles[x][y+1]) then
							love.graphics.draw(tileRef[10],(x-1)*box,((y-1)*box)+hBox)
						end
					end
					if y>1 then
						if checkIt2(tiles[x][y-1]) then
							love.graphics.draw(tileRef[10],(x-1)*box,((y-1)*box)-hBox)
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
							love.graphics.draw(tileRef[10],((x-1)*box)+hBox,((y-1)*box)+hBox)
						end
					end
				end
			end
			if atoms[x][y] ~= 0 then
				love.graphics.print(atoms[x][y],((x-1)*50)+20,((y-1)*50)+20)
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
		if bl then
			tiles[xPos][yPos] = blockToPlace
		else
			atoms[xPos][yPos] = atom
		end
	elseif button == "r" then
		tiles[xPos][yPos] = 0
		atoms[xPos][yPos] = 0
	elseif button == "m" then
		tiles[xPos][yPos] = playerNo
	end
end

function levelEdit.keypressed(key,unicode)
	if key == "s" then
		local file,size = love.filesystem.read("levels.lua")
		local p,q = string.find(file,"level")
		local levNum = string.sub(file,q+1,q+1) + 1
		print(levNum)
		local levelData = "level" .. levNum .. " = {"
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
		levelData = levelData .. "}		" .. file
		print(love.filesystem.write("levels.lua",levelData,all))
	end
	if atomEntry then
		if key == "h" then
			bl = false
			atom = "H"
			atomEntry = false
		end
		if key == "u" then
			bl = false
			atom = "Cu"
			atomEntry = false
		end
		if key == "c" then
			bl = false
			atom = "C"
			atomEntry = false
		end
		if key == "n" then
			bl = false
			atom = "N"
			atomEntry = false
		end
		if key == "s" then
			bl = false
			atom = "S"
			atomEntry = false
		end
	else
		if key == "l" then
			bl = true
			tiles = level
		end
		if key == "x" then
			bl = true
			gamestate = menu
		end
		if key == "1" then
			bl = true
			blockToPlace = 2
		end
		if key == "2" then
			bl = true
			blockToPlace = 6
		end
		if key == "3" then
			bl = true
			blockToPlace = 7
		end
		if key == "4" then
			bl = true
			blockToPlace = 8
		end
		if key == "5" then
			bl = true
			blockToPlace = 9
		end
		if key == "6" then
			bl = true
			blockToPlace = 11
		end
		if key == "0" then
			atomEntry = true
		end
	end
end

function checkIt(val) --vals will be added to this
	if val == 2 then return true else return false end
end

function checkIt2(val)
	if val == 9 then return true else return false end
end