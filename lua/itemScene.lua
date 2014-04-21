
ItemScene = Controller:create()

function ItemScene:getCreateHandler()
	local createrHandler = function(data)
		local o = ItemScene:create(data)
		return o
	end
	return createrHandler
end

function ItemScene:create(o)
	o = getmetatable(self):create(o)
	setmetatable(o, self)
	self.__index = self

	-- variable:

	-- init
	local topNode = o:loadCCBScene("Gui10.ccbi")
	o.btnBack = topNode:getChildByTag(2):getChildByTag(3):getChildByTag(1)
	tolua.cast(o.btnBack, "CCMenuItemImage")

	o.btnBack:registerScriptTapHandler(self.btnbackCallback)
	
	log("ItemScene:create")
	return o
end

function ItemScene:destroy()
	Controller.destroy(self)
	
	log("ItemScene:destroy")
end

function ItemScene:test()
 	log("ItemScene:test")
end

function ItemScene:btnbackCallback(tag, sender)
	log("btnbackCallback")
	-- SceneMgr:sharedSceneMgr():popToScene("main")
	SceneMgr:sharedSceneMgr():pop()
end