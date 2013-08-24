menu = {}

function menu.draw()
	love.graphics.print("press l to enter level editor or g to play",200,200)
end

function menu.update()

end

function menu.keypressed(key)
	if key == "l" then
		gamestate = levelEdit
	elseif key == "g" then
		gamestate = game
	end
end