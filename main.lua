require("game")
require("levelEdit")
require("origLevels")
require("menu")

w=16
h=12
box=50
hBox=25
qBox=12
playerNo=1   --where the player is in tileRefs

gamestate = menu

block = love.graphics.newImage("tempBlock.png")  --CHANGE THIS SOON
side = love.graphics.newImage("tempBlockSide.png")
player1 = love.graphics.newImage("player.png")  --AND THIS
player2 = love.graphics.newImage("player2.png")
player3 = love.graphics.newImage("player3.png")
player4 = love.graphics.newImage("player4.png")
exit = love.graphics.newImage("tempBlockExit.png")
blockade = love.graphics.newImage("tempBlockade.png")
fan = love.graphics.newImage("tempBlockFan.png")
copper = love.graphics.newImage("tempBlockCopper.png")
door = love.graphics.newImage("tempBlockDoor.png")
player = player1
font = love.graphics.newFont("5x5_pixel.ttf",18)
love.graphics.setFont(font)

tiles = {}
atoms = {}
tileRef = {player,block,side,side,side,exit,blockade,fan,copper,copper,door}  --naming order: player, block, sideblock (x+-1), top and bottom block (y+-1),diagnol block(x+-1,y+-1), ...

function love.load()
	temp = love.filesystem.load("levels.lua")
	temp()
	for x=1,w,1 do  --from here...
		table.insert(tiles,{})
		table.insert(atoms,{})
		for y=1,h,1 do
			table.insert(tiles[x],0)
			table.insert(atoms[x],0)
		end
	end
	--[[
	for x=1,w,1 do
		for y=1,h,1 do
			tiles[x][y] = math.random(0,1)
			if tiles[x][y] == 1 then tiles[x][y] = 2 end
		end
	end  ]]--to here will be replaced with a level loading function
end

function love.draw()
	gamestate.draw()
end

function love.update(dt)
	if gamestate.update then
		gamestate.update(dt)
	end
end

function love.mousepressed(x, y, button)
	if gamestate.mousepressed then
		gamestate.mousepressed(x, y, button)
	end
end

function love.mousereleased(x, y, button)
	if gamestate.mousereleased then
		gamestate.mousereleased(x, y, button)
	end
end

function love.keypressed(key, unicode)
	if gamestate.keypressed then
		gamestate.keypressed(key)
	end
end

function love.keyreleased(key)
	if gamestate.keyreleased then
		gamestate.keyreleased(key)
	end
end