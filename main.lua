tiles = {}
tileRef = {}

function love.load()  --each tile is 25x25
	for x=1,32,1 do
		table.insert(tiles,{})
		for y=1,24,1 do
			table.insert(tiles[x],0)
		end
	end
end

function love.draw()

end

function love.update()

end