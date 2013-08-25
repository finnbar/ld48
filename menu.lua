menu = {}

function menu.draw()
	win = false
	love.graphics.setFont(largeFont)
	love.graphics.print("YOU HAVE TO GET THE ATOMS",150,200)
	love.graphics.print("press l to enter level editor",120,400)
	love.graphics.print("or press g to play",230,450)
	love.graphics.setFont(font)
	love.graphics.print("you must",50,100)
	love.graphics.print("it is a given",600,150)
	love.graphics.print("why would you not",400,550)
	love.graphics.print("they give you points",500,50)
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