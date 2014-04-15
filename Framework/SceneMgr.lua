-----------------------------------------------------------------------------------------------------
-----
-----  controller manager, maintain a scene stack, record data to rebuild scene.
-----
-----------------------------------------------------------------------------------------------------

SceneMgr = {}

function SceneMgr:sharedSceneMgr()
	if sceneMgrInstance == nil then
		log("init SceneMgr")
		sceneMgrInstance = {}
		setmetatable(sceneMgrInstance, self)
		self.__index = self
		
		-- variable:
		sceneMgrInstance.nameStack = {}
		sceneMgrInstance.dataStack = {}
		sceneMgrInstance.size = 0
	end

	return sceneMgrInstance
end

function SceneMgr:push(name, data)
	local obj = Factory:sharedFactoryMgr():getInstance(name, data)
	if obj == nil then
		log("ERROR ! Can't create instance : '"..name.."' .")
		return
	end

	self.size = self.size + 1
	self.nameStack[self.size] = name
	if data ~= nil then
		self.dataStack[self.size] = data
	else
		self.dataStack[self.size] = {}
	end

	self:printStack()
end

function SceneMgr:pop()
	if self.size <= 0 then
		log("Scene stack is empty !")
		return
	end

	self.dataStack[self.size] = nil
	self.dataStack[self.size] = nil
	self.size = self.size - 1

	self:printStack()
end

function SceneMgr:replace(name, data)
	self:pop()
	self:push(name, data)
end

function SceneMgr:printStack()
	log("=====================================")
	log("size : "..self.size)
	for i=1, self.size do
		log(i.." name : "..self.nameStack[i].." - data : "..tostring(self.dataStack[i]))
	end
	log("=====================================")
end

-- singleton instance pointer
sceneMgrInstance = nil