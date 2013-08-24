game = {}
complete = false
count = 1
plX = 0
plY = 0

function game.update()
	if complete then
		count = count + 1
		tiles = levels[count]
		for x=1,w,1 do
			for y=1,h,1 do
				if tiles[x][y] == 5 then
					plX = (x-1)*box
					plY = (y-1)*box
					tiles[x][y] = 0
					break
				end
			end
		end
	end
	playerStuff()
end

function game.draw()
	love.graphics.draw(player,plX,plY)
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
end

function playerStuff()

end