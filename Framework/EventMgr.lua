-----------------------------------------------------------------------------------------------------
-----
-----  controller manager, maintain a scene stack, record data to rebuild scene.
-----
-----------------------------------------------------------------------------------------------------

EventMgr = {}

function EventMgr:sharedEventMgr()
	if eventMgrInstance == nil then
		log("init EventMgr")
		eventMgrInstance = {}
		setmetatable(eventMgrInstance, self)
		self.__index = self
		
		-- variable:
		eventMgrInstance.eventToListeners = {}
		eventMgrInstance.listenersToEvent = {}
	end

	return eventMgrInstance
end

function EventMgr:destroy()
	if eventMgrInstance == nil then
		return
	end

	eventMgrInstance.listeners = nil
	eventMgrInstance = nil
end

function EventMgr:addListener(event, listener)
	local name = listener:getName()

	if self.eventTolisteners[event] == nil then
		self.eventTolisteners[event] = {}
	end
	self.eventTolisteners[event][name] = listener

	if self.listenersToEvent[name] == nil then
		self.listenersToEvent[name] = {}
	end
	self.listenersToEvent[name][event] = listener
end

function EventMgr:removeListener(listener)
	local name = listener:getName()

	for event, listener in pairs(self.listenersToEvent[name]) do
		self.eventTolisteners[event][name] = nil
	end

	self.listenersToEvent[name] = nil
end

function EventMgr:dispatchEvent(event, data)
	for name, listener in pairs(self.eventTolisteners[event]) do
		listener:handleEvent(event, data)
	end
end

-- singleton instance pointer
eventMgrInstance = nil
