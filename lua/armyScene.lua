
ArmyScene = Controller:create()

function ArmyScene:create(o)
	o = getmetatable(self):create(o)

	-- variable:

	return o
end

function ArmyScene:getCreateHandler()
	
	local createrHandler = function(data)
		local o = ArmyScene:create(data)
		return o
	end
	
	return createrHandler
end

function ArmyScene:test()
 	log("ArmyScene:test")
end

