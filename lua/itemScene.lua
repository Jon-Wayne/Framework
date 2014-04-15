
ItemScene = Controller:create()

function ItemScene:create(o)
	o = getmetatable(self):create(o)

	-- variable:

	return o
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

