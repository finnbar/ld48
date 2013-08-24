game = {}
complete = true
count = 0
plX = 200
plY = 200
lHold = 0
rHold = 0
uHold = 0
oldX = 0
oldY = 0
xPos = 1
yPos = 1

function game.update(dt)
	if complete then
		count = count + 1
		tiles = levels[count]
		for x=1,w,1 do
			for y=1,h,1 do
				if tiles[x][y] == 1 then
					plX = (x-1)*box
					plY = (y-1)*box
					tiles[x][y] = 0
					oldX = x
					oldY = y
					break
				end
			end
		end
		complete = false
	end
	playerStuff(dt)
end

function game.draw()
	love.graphics.rectangle("line",(xPos-1)*50,(yPos-1)*50,50,50)
	love.graphics.draw(player,plX,plY+12)
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
end

function playerStuff(dt)
	if up then
		plY = plY - (200*dt)
		player = player1
	elseif down then
		plY = plY + (200*dt)
		player = player3
	end
	if left then
		plX = plX - (200*dt)
		player = player4
	elseif right then
		plX = plX + (200*dt)
		player = player2
	end
	--plY = plY + (100*dt)
	if plY>0 and plX>0 then
		xPos = math.ceil((plX-36.5)/50)+1
		yPos = math.ceil((plY-25)/50)+1
		print(xPos,yPos)
		if tiles[xPos][yPos] ~= 0 then
			--[[
			if left then
				plX = plX + (200*dt)
			elseif right then
				plX = plX - (200*dt)
			end
			plY = plY - (200*dt)
			]]--
			if oldX > plX then
				plX = plX + (200*dt)
			elseif oldX < plX then
				plX = plX - (200*dt)
			end
			if oldY > plY then
				plY = plY + (200*dt)
			elseif oldY < plY then
				plY = plY - (200*dt)
			end
		end
	else
		if plX<10 then plX=10 end
		if plY<10 then plY=10 end
	end
	oldX = plX
	oldY = plY
end

function checkIt(val)
	if val == 2 or val == 7 then
		return true
	else
		return false
	end
end

function game.keypressed(key)
	if key == "up" then
		up = true
	end
	if key == "down" then
		down = true
	end
	if key == "left" then
		left = true
	end
	if key == "right" then
		right = true
	end
end

function game.keyreleased(key)
	if key == "up" then
		up = false
	end
	if key == "down" then
		down = false
	end
	if key == "left" then
		left = false
	end
	if key == "right" then
		right = false
	end
end