
ItemScene = Controller:create()

function ItemScene:create(o)
	o = getmetatable(self):create(o)
	setmetatable(o, self)
	self.__index = self

	-- variable:

	-- init
	o:loadCCBScene("Gui10.ccbi")
	
	log("ItemScene:create")
	return o
end

function ItemScene:destroy()
	Controller.destroy(self)
	
	log("ItemScene:destroy")
end

function ItemScene:getCreateHandler()
	
	local createrHandler = function(data)
		local o = ItemScene:create(data)
		return o
	end
	
	return createrHandler
end

function ItemScene:test()
 	log("ItemScene:test")
end

