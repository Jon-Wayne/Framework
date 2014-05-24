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

	if obj:isRemoveBefore() and self.size > 0 then
		log("Release controller : "..self.size)
		self:removeScene(self.size)
	end

	self.size = self.size + 1
	self.nameStack[self.size] = name
	self.cntrStack[self.size] = obj
	if data ~= nil then
		self.dataStack[self.size] = data
	else
		self.dataStack[self.size] = NULL
	end

	local events = obj:expectedEvents
	if events then
		for _, event in pairs(events) do
			EventMgr:sharedEventMgr():addListener(event, obj)
		end
	end
	
	self.rootScene:addChild(obj.scene, self.size, self.size)

	self:printStack()
end

function SceneMgr:pop()
	if self.size <= 0 then
		log("Scene stack is empty !")
		return
	end

	self:removeScene(self.size, true)

	self:resumeScene(self.size)

	self:printStack()
end

function SceneMgr:popToScene(name)
	local index = -1
	for i=self.size-1 , 1, -1 do
		if self.nameStack[i] == name then
			index = i
			break
		end
	end

	if index == -1 then
		log("No scene named: "..name)
		return
	end

	log("Pop to scene name: "..name.." index: "..index)

	for i=self.size, index+1, -1 do
		self:removeScene(self.size, true)
	end

	self:resumeScene(self.size)

	self:printStack()
end

function SceneMgr:replace(name, data)
	self:pop()
	self:push(name, data)
end

function SceneMgr:removeScene(index, isPop)
	if index < 1 or index > self.size then
		log("Can not remove scene index: "..index)
		return
	end

	if self.cntrStack[self.size] ~= NULL then
		self.rootScene:removeChildByTag(self.size, true)

		EventMgr:sharedEventMgr():removeListener(self.cntrStack[self.size])

		self.cntrStack[self.size]:destroy()
	end

	-- if remove top scene, pop it
	if isPop == true then
		self.nameStack[self.size] = nil
		self.cntrStack[self.size] = nil
		self.dataStack[self.size] = nil
		self.size = self.size - 1
	else
		self.cntrStack[self.size] = NULL
	end
end

function SceneMgr:resumeScene(index)
	if index < 1 or index > self.size then
		log("Can not remove scene index: "..index)
		return
	end

	if self.cntrStack[index] == NULL then
		local name = self.nameStack[index]
		local data = self.dataStack[index]
		if data == NULL then data = nil end
		local obj = Factory:sharedFactoryMgr():getInstance(name, data)
		if obj == nil then
			log("ERROR ! Can't create instance : '"..name.."' .")
			return
		end
		self.cntrStack[index] = obj

		local events = obj:expectedEvents
		if events then
			for _, event in pairs(events) do
				EventMgr:sharedEventMgr():addListener(event, obj)
			end
		end

		self.rootScene:addChild(obj.scene, index, index)
	end
end

function SceneMgr:refreshTopScene()
	if self.size > 0 then
		return
	end

	self.cntrStack[self.size]:reset()
	self.cntrStack[self.size]:refresh()
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
