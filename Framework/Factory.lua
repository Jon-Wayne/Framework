-----------------------------------------------------------------------------------------------------
-----
-----  controller factory, used to get class instance create handler.
-----
-----------------------------------------------------------------------------------------------------

Factory = {}

function Factory:sharedFactoryMgr()
	if factoryInstance == nil then
		log("init Factory")
		factoryInstance = {}
		setmetatable(factoryInstance, self)
		self.__index = self
		
		-- variable:
		factoryInstance.map = {}
	end

	return factoryInstance
end

function Factory:register(name, handler)
	if self.map[name] ~= nil then
		log("ERROR ! The name '"..name.."' have exist in Factory map !")
		return
	end

	self.map[name] = handler
end

function Factory:getInstance(name, data)
	if self.map[name] == nil then
		log("ERROR ! The name '"..name.."' don't exist in Factory map !")
		return nil
	end

	local handler = self.map[name]
	local obj = handler(data)

	return obj
end

function Factory:printMap()
	logTable(self.map)
end


-- singleton instance pointer
factoryInstance = nil