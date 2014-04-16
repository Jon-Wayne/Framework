
ArmyScene = Controller:create()

function ArmyScene:create(o)
	o = getmetatable(self):create(o)
	setmetatable(o, self)
	self.__index = self

	-- variable:
	log("ArmyScene:create")
	return o
end

function ArmyScene:destroy()
	Controller.destroy(self)
	
	log("ArmyScene:destroy")
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

