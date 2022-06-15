local mockLove = require("Tests_specs.mocked_love")
local Player = require("Scripts.player")


describe('Player => Positioning =>', function()
	
	local player
	before_each(function()
		player = Player()
	end)
	
	it("On no load called, player position is 0,0", function()
		assert.is_equal(0, player.x)
		assert.is_equal(0, player.y)
	end)

	it("On Load() called, player position is 32,32", function()
		player:Load()
		assert.is_equal(32, player.x)
		assert.is_equal(32, player.y)
	end)
end)

describe('Player => Velocity Movement =>', function()
	
	local player
	before_each(function()
		player = Player()
	end)

	it("On no load called, player velocity is 0", function()
		assert.is_equal(0, player.velocity)
	end)

	it("On Load() called, player velocity is 25", function()
		player:Load()
		assert.is_not_equal(0, player.velocity)
	end)
end)

describe('Player => Movementation Update =>', function()
	
	local player
	before_each(function()
		player = Player()
	end)

	it("On call update before Load, move to right +1", function()
		player.velocity = 1
		player:Update(1)
		assert.is_equal(1, player.x)
	end)

	it("On call update before Load, NOT move to down +0", function()
		player:Update(1)
		assert.is_equal(0, player.y)
	end)

	it("On direction is zero (0) player move to right", function()
		player:Load()
		player.direction = 0
		player.velocity = 1
		player:Update(1)
		assert.is_equal(33, player.x)
	end)

	it("On direction is one (1) player move to down", function()
		player:Load()
		player.direction = 1
		player.velocity = 1
		player:Update(1)
		assert.is_equal(33, player.y)
	end)

	it("On direction is two (2) player move to left", function()
		player:Load()
		player.direction = 2
		player.velocity = 1
		player:Update(1)
		assert.is_equal(31, player.x)
	end)

	it("On direction is three (3) player move to up", function()
		player:Load()
		player.direction = 3
		player.velocity = 1
		player:Update(1)
		assert.is_equal(31, player.y)
	end)

	it("Velocity at 0.5 influences the result to 32.5", function()
		player:Load()
		player.velocity = 0.5
		player:Update(1)
		assert.is_equal(32.5, player.x)
	end)

	it("Velocity at 2 influences the result to 34", function()
		player:Load()
		player.velocity = 2
		player:Update(1)
		assert.is_equal(34, player.x)
	end)
end)

describe('Player => Receiving Input =>', function()
	
	local player
	before_each(function()
		player = Player()
	end)
	
	it("On nothing being called, the direction is right (0)", function()
		assert.is_equal(0, player.direction)
	end)
	
	it("On 'right' being called, the direction is right (0)", function()
		player.direction = 1
		player:KeyPressed("right")
		assert.is_equal(0, player.direction)
	end)
	
	it("On 'down' being called, the direction is down (1)", function()
		player:KeyPressed("down")
		assert.is_equal(1, player.direction)
	end)
	
	it("On 'left' being called, the direction is left (2)", function()
		player:KeyPressed("left")
		assert.is_equal(2, player.direction)
	end)
	
	it("On 'up' being called, the direction is up (3)", function()
		player:KeyPressed("up")
		assert.is_equal(3, player.direction)
	end)

end)

describe('Check if Player is being drawn =>', function()
	
	local player
	before_each(function()
		player = Player()
	end)
	
	it("Check if Rectangle is being called", function()
		local s = spy.on(love.graphics, "rectangle")
		
		player:Draw()

		assert.spy(s).was_called()
	end)

	it("Check if before load the draw is on 0,0", function()
		--player:Load()
		local t,x,y,w,h = player:Draw()
		assert.is_equal(0, x)
		assert.is_equal(0, y)
	end)

	it("Check if after load the draw is on 32,32", function()
		player:Load()
		local t,x,y,w,h = player:Draw()
		assert.is_equal(32, x)
		assert.is_equal(32, y)
	end)

end)

