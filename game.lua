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
mini = 0
win = false
miniPlus = 1
timer = 10
shooting = false
timerDis = 0
toSwap = 0
powers = {}
colourList = {}
moleculeID = {{"C","O","gas"},{"Cu","O","conductive"},{"N","H","explosive"},{"Na","H","poison"}}
playerPowers = {}
shapesList = {"circle","line","triangle","square","pentagon","hexagon","septagon","octagon","nonagon","decagon"}  --for streaks
firstTime = true
streak = -1
exit = false
countert = 0

function game.load()
	love.audio.play(mainTrack)
end

function game.update(dt)
	if not win then
		if firstTime then
			firstTime = false
			game.load()
		end
		if complete then
			reset(true)
		end
		playerStuff(dt)
		timer = timer - dt
		if timer <= 0 then
			reset(false)
		end
	end
end

function game.draw()
	if win then
		love.graphics.setFont(largeFont)
		love.graphics.print("CONGRATS YOU BEAT THE TUTORIAL",100,200)
		love.graphics.print("SCORE",300,300)
		if streak > 0 then
			if streak < 11 then
				love.graphics.print(shapesList[streak],200,400)
			else
				love.graphics.print("DECAGON PLUS",200,400)
			end
		else
			love.graphics.print("nil",300,400)
		end
		love.graphics.print("press x to go back to the menu",200,500)
	else
		if streak > 0 then
			if streak < 11 then
				love.graphics.print("score is " .. shapesList[streak],550,600)
			else
				love.graphics.print("score is DECAGON PLUS",550,600)
			end
		else
			love.graphics.print("score is nil",550,600)
		end
		electricity()
		timerDis = tonumber(string.format("%." .. 2 .. "f",timer))
		timerDis = timerDis*100
		--print(timerDis)
		love.graphics.setFont(largeFont)
		love.graphics.setColor(255,timerDis/3.921568627,0)
		love.graphics.print(timerDis,10,610)
		love.graphics.setColor(255,255,255)
		if powers ~= nil then
			for a=1,#powers,1 do
				local partOf = 0
				for b=1,#moleculeID,1 do
					love.graphics.setColor(255,255,255)
					if powers[a] == moleculeID[b][1] then
						partOf = moleculeID[b][3]
					elseif powers[a] == moleculeID[b][2] then
						partOf = moleculeID[b][3]
					end
					if partOf == "poison" then
						for c=1,#playerPowers,1 do
							if playerPowers[c] == "poison" then
								love.graphics.setColor(0,255,0)
							end
						end
					end
					if partOf == "conductive" then
						for c=1,#playerPowers,1 do
							if playerPowers[c] == "conductive" then
								love.graphics.setColor(255,160,100)
							end
						end
					end
					if partOf == "gas" then
						for c=1,#playerPowers,1 do
							if playerPowers[c] == "gas" then
								love.graphics.setColor(0,255,100)
							end
						end
					end
					if partOf == "explosive" then
						for c=1,#playerPowers,1 do
							if playerPowers[c] == "explosive" then
								love.graphics.setColor(255,0,0)
							end
						end
					end
					love.graphics.print(powers[a],(a*60)+40,610)
				end
			end
		end
		love.graphics.setColor(255,255,255)
		love.graphics.setFont(font)
		colourList = {}
		for a=1,#playerPowers,1 do
			if playerPowers[a] == "poison" then
				table.insert(colourList,{0,255,0})
			end
			if playerPowers[a] == "explosive" then
				table.insert(colourList,{255,0,0})
			end
			if playerPowers[a] == "gas" then
				table.insert(colourList,{0,255,100})
			end
			if playerPowers[a] == "conductive" then
				table.insert(colourList,{255,160,100})
			end
		end
		local tab = {}
		if mini > 50 then
			miniPlus = miniPlus + 1
		else mini = mini + 1 end
		if #colourList < miniPlus then miniPlus = 1 end
		if colourList[1] == nil then
			tab = {255,255,255}
		else tab = colourList[miniPlus] end
		love.graphics.setColor(tab[1],tab[2],tab[3])
		love.graphics.rectangle("line",(xPos-1)*50,(yPos-1)*50,50,50)
		love.graphics.setColor(255,255,255)
		love.graphics.draw(player,plX,plY+12)
		for x=1,w,1 do
			for y=1,h,1 do
				if tiles[x][y] ~= 0 then
					if type(tiles[x][y]) == "number" then
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
				end
				if tiles[x][y] ~= 0 and tiles[x][y] ~= nil then
					if type(tiles[x][y]) == "string" then
						love.graphics.print(tiles[x][y],((x-1)*50)+20,((y-1)*50)+20)
					end
				end
			end
		end
		if tiles[w+1] ~= nil then
			love.graphics.print(tiles[w+1][1],tiles[w+1][2],tiles[w+1][3])
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
		--print(xPos,yPos)
		if tiles[xPos][yPos] ~= 0 then
			if tiles[xPos][yPos] ~= 12 then
				if tiles[xPos][yPos] == 6 then complete = true end
				for a=1,#playerPowers,1 do
					if playerPowers[a] == "poison" then
						if tiles[xPos][yPos] == 2 then tiles[xPos][yPos] = 0 end
					end
					if playerPowers[a] == "gas" then
						if tiles[xPos][yPos] == 8 then
							tiles[xPos][yPos] = 14
						end
					end
					if playerPowers[a] == "explosive" then
						if tiles[xPos][yPos] == 7 then tiles[xPos][yPos] = 0 end
					end
				end
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
				if tiles[xPos][yPos] ~= 0 then
					if type(tiles[xPos][yPos]) == "string" then
						table.insert(powers,tiles[xPos][yPos])
						tiles[xPos][yPos] = 0
					end
				end
			end
		end
	else
		if plX<10 then plX=10 end
		if plY<10 then plY=10 end
	end
	playerPowers = {}
	local lengthPowers = #powers-1
	--print(lengthPowers)
	if lengthPowers > 0 then
		for a=1,lengthPowers,1 do
			--print(powers[a],a)
			for b=1,#moleculeID,1 do
				if powers[a] == moleculeID[b][1] then
					if powers[a+1] == moleculeID[b][2] then
						table.insert(playerPowers,moleculeID[b][3])
					end
				end
				if powers[a+1] == moleculeID[b][1] then
					if powers[a] == moleculeID[b][2] then
						table.insert(playerPowers,moleculeID[b][3])
					end
				end
				local test = true
				for i=1,#playerPowers,1 do
					if playerPowers[i] == "gas" then
						test = false
						break
					end
				end
				if test then
					if powers[a] == "C" then
						if powers[a+1] == "O" then
							table.insert(playerPowers,"gas")
						end
					end
					if powers[a] == "O" then
						if powers[a+1] == "C" then
							table.insert(playerPowers,"gas")
						end
					end
				end
			end
		end
	end
	--print(powers[#powers])
	for x=1,#playerPowers,1 do
		if playerPowers[x] ~= nil then
			print(playerPowers[x])
		end
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

function electricity()
	for x=1,w,1 do
		for y=1,h,1 do
			conduction[x][y] = 0
		end
	end
	for a=1,#playerPowers,1 do
		if playerPowers[a] == "conductive" then
			xPos = math.ceil((plX-36.5)/50)+1
			yPos = math.ceil((plY-25)/50)+1
			conduction[xPos][yPos] = 1
		end
	end
	--add fan rules
	local notDone = true
	while notDone do
		notDone = false
		for x=1,w,1 do
			for y=1,h,1 do
				if tiles[x][y] == 14 then conduction[x][y] = 1 end
				if conduction[x][y] == 1 then
					--print(x,y)
					for a=-1,1,1 do
						for b=-1,1,1 do
							local xd = x + a
							local yd = y + b
							--print(xd,yd)
							if xd>1 and xd<=w and yd>1 and yd<=h then
								if conduction[xd][yd] == 0 then
									if type(tiles[xd][yd]) == "number" then
										if tiles[xd][yd] > 7 and tiles[xd][yd] < 12 then --8,9,10,11
											--print(xd,yd)
											conduction[xd][yd] = 1
											notDone = true
										end
									end
								end
							end
						end
					end
				end
			end
		end
		for x=1,w,1 do
			for y=1,h,1 do
				if conduction[x][y] == 1 then
					if tiles[x][y] == 9 then
						tiles[x][y] = 13
					elseif tiles[x][y] == 11 then
						tiles[x][y] = 12
					elseif tiles[x][y] == 8 then
						tiles[x][y] = 14
					end
				end
			end
		end
	end
end

function game.keypressed(key)
	if key == "x" then
		gamestate = menu
	end
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
	if key == "space" then
		shooting = true
	end
	if key == "1" then
		swapem(1)
	end
	if key == "2" then
		swapem(2)
	end
	if key == "3" then
		swapem(3)
	end
	if key == "4" then
		swapem(4)
	end
	if key == "5" then
		swapem(5)
	end
	if key == "6" then
		swapem(6)
	end
	if key == "7" then
		swapem(7)
	end
	if key == "8" then
		swapem(8)
	end
	if key == "9" then
		swapem(9)
	end
	if key == "0" then
		swapem(10)
	end
end

function swapem(newKey)
	if toSwap == 0 then
		toSwap = newKey
	else
		local switch = powers[toSwap]
		if switch ~= nil then
			powers[toSwap] = powers[newKey]
			powers[newKey] = switch
		end
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
	if key == "space" then
		shooting = false
	end
end

function reset(newLev)
	timer = 10
	if newLev then
		count = count + 1
		if count > #levels then win = true end
		streak = streak + 1
		complete = false
	else
		love.audio.rewind(mainTrack)
		streak = 0
	end
	if not win then
		for x=1,w,1 do
			for y=1,h,1 do
				tiles[x][y] = levels[count][x][y]
			end
		end
		if levels[count][w+1] ~= nil then
			for y=1,3,1 do
				tiles[w+1][y] = levels[count][w+1][y]
			end
		end
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
		powers = {}
	end
end