
MainScene = Controller:create()

function MainScene:create(o)
	o = getmetatable(self):create(o)

	-- variable:

	return o
end

function MainScene:getCreateHandler()

	local createrHandler = function(data)
		local o = MainScene:create(data)
		return o
	end
	
	return createrHandler
end

function MainScene:test()
 	log("MainScene:test")
end

