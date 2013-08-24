game = {}
complete = true
count = 0
plX = 0
plY = 0
lHold = 0
rHold = 0
uHold = 0

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
					break
				end
			end
		end
		complete = false
	end
	playerStuff(dt)
end

function game.draw()
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
			end
		end
	end
end

function playerStuff(dt)
	if up then
		plY = plY - (400*dt)
		uHold = 10
	else
		if uHold > 0 then
			plY = plY - (uHold*60*dt)
			uHold = uHold - 1
		end
	end
	if down then
		plY = plY + (200*dt)
	end
	if left then
		plX = plX - (200*dt)
		lHold = 20
	else
		if lHold > 0 then
			plX = plX - (lHold*15*dt)
			lHold = lHold - 1
		end
	end
	if right then
		plX = plX + (200*dt)
		rHold = 20
	else
		if rHold > 0 then
			plX = plX + (rHold*15*dt)
			rHold = rHold - 1
		end
	end
	plY = plY + (200*dt)
	local compX = math.ceil(plX/50) + 1
	local compY = math.ceil(plY/50) + 1
	--print(compX,compY)
	if tiles[compX][compY] ~= 0 then
		--[[    UNCOMMENTING THIS CAUSES PROBLEMS W/ MOVEMENT
		if right then
			plX = plX - (200*dt)
		elseif left then
			plX = plX + (200*dt)
		end
		]]--
		plY = plY - (200*dt)
	end
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