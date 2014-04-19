
ArmyScene = Controller:create()

function ArmyScene:create(o)
	o = getmetatable(self):create(o)
	setmetatable(o, self)
	self.__index = self

	-- variable:

	-- init
	local topNode = o:loadCCBScene("Gui08.ccbi")
	o.btnBack = topNode:getChildByTag(2):getChildByTag(1):getChildByTag(5):getChildByTag(1)
	tolua.cast(o.btnBack, "CCMenuItemImage")

	o.btnBack:registerScriptTapHandler(self.btnbackCallback)
	
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

function ArmyScene:btnbackCallback(tag, sender)
	log("btnbackCallback")
	SceneMgr:sharedFactoryMgr():pop()
end