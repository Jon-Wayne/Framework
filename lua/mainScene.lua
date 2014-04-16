
MainScene = Controller:create()

function MainScene:create(o)			-- !!! [self] = [MainScene class template] here !!!
	o = getmetatable(self):create(o)	-- 1 [o] = [Controller:create()], so [o] = [MainScene] now.
	setmetatable(o, self)				-- 2 change the meta table of o, it's Controller before, but MainScene now, so level of o is "dowm".
	self.__index = self					-- 3 

	-- variable:
	o.players = {50000022, 51515, 1515, 515}

	log("MainScene:create")

	return o
end

function MainScene:destroy()
	Controller.destroy(self)

	self.players = nil
	log("MainScene:destroy")
end

function MainScene:getCreateHandler()

	local createrHandler = function(data)
		local o = MainScene:create(data)
		return o
	end
	
	return createrHandler
end

function MainScene:test()
	-- getmetatable(self):test()		-- wrong: = getmetatable(self).test(getmetatable(self)), it will 
	-- getmetatable(self).test(self)
	Controller
 	log("MainScene:test")
end

-- the final reason is: "self" is different in different situation