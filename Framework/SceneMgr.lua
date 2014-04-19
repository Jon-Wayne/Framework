-----------------------------------------------------------------------------------------------------
-----
-----  controller manager, maintain a scene stack, record data to rebuild scene.
-----
-----------------------------------------------------------------------------------------------------

local NULL = "NULL"

SceneMgr = {}

function SceneMgr:sharedSceneMgr()
	if sceneMgrInstance == nil then
		log("init SceneMgr")
		sceneMgrInstance = {}
		setmetatable(sceneMgrInstance, self)
		self.__index = self
		
		-- variable:
		sceneMgrInstance.rootScene = CCScene:create()
		sceneMgrInstance.rootScene:retain()

		sceneMgrInstance.nameStack = {}
		sceneMgrInstance.cntrStack = {}
		sceneMgrInstance.dataStack = {}
		sceneMgrInstance.size = 0
	end

	return sceneMgrInstance
end

function SceneMgr:destroy()
	if sceneMgrInstance == nil then
		return
	end

	sceneMgrInstance.rootScene:release()

	sceneMgrInstance.nameStack = nil
	sceneMgrInstance.cntrStack = nil
	sceneMgrInstance.dataStack = nil
	sceneMgrInstance.size = 0

	sceneMgrInstance = nil
end

function SceneMgr:push(name, data)
	local obj = Factory:sharedFactoryMgr():getInstance(name, data)
	if obj == nil then
		log("ERROR ! Can't create instance : '"..name.."' .")
		return
	end

	if obj:isReleaseBefore() and self.size > 0 then
		log("release controller : "..self.size)
		self.cntrStack[self.size]:destroy()
		self.cntrStack[self.size] = NULL
		self.rootScene:removeChildByTag(self.size, true)
	end

	self.size = self.size + 1
	self.nameStack[self.size] = name
	self.cntrStack[self.size] = obj
	if data ~= nil then
		self.dataStack[self.size] = data
	else
		self.dataStack[self.size] = NULL
	end
	
	self.rootScene:addChild(obj.scene, self.size, self.size)

	self:printStack()
end

function SceneMgr:pop()
	if self.size <= 0 then
		log("Scene stack is empty !")
		return
	end

	self.rootScene:removeChildByTag(self.size, true)

	self.cntrStack[self.size]:destroy()

	self.nameStack[self.size] = nil
	self.cntrStack[self.size] = nil
	self.dataStack[self.size] = nil
	self.size = self.size - 1

	if self.size > 0 and self.cntrStack[self.size] == NULL then
		local name = self.nameStack[self.size]
		local data = self.dataStack[self.size]
		if data == NULL then data = nil end
		local obj = Factory:sharedFactoryMgr():getInstance(name, data)
		if obj == nil then
			log("ERROR ! Can't create instance : '"..name.."' .")
			return
		end
		self.rootScene:addChild(obj.scene, self.size, self.size)
	end

	self:printStack()
end

function SceneMgr:replace(name, data)
	self:pop()
	self:push(name, data)
end

function SceneMgr:printStack()
	log("==========================================================================")
	log("size : "..self.size)
	for i=self.size, 1, -1 do
		log(i, "[Name: "..self.nameStack[i].."]", "[Controller: "..tostring(self.cntrStack[i]).."]", "[Data: "..tostring(self.dataStack[i]).."]")
	end
	log("==========================================================================")
end

-- singleton instance pointer
sceneMgrInstance = nil
