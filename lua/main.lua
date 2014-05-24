-----------------------------------------------------------------------------------------------------
-----
-----	script files execution entrence.
-----	"compile" all lua files, all script files are only loaded one time here.
-----
-----------------------------------------------------------------------------------------------------

-- add Framework lib
require("Framework.lua")

local function main()
	compile("sceneDefine.lua")
	compile("mainScene.lua")
	compile("itemScene.lua")
	compile("armyScene.lua")

	Factory:sharedFactoryMgr():register(SCENE_MAIN, MainScene:getCreateHandler())
	Factory:sharedFactoryMgr():register(SCENE_ARMY, ArmyScene:getCreateHandler())
	Factory:sharedFactoryMgr():register(SCENE_ITEM, ItemScene:getCreateHandler())
	Factory:sharedFactoryMgr():printMap()

	CCDirector:sharedDirector():runWithScene(SceneMgr:sharedSceneMgr().rootScene)

	SceneMgr:sharedSceneMgr():push("main", {})
	SceneMgr:sharedSceneMgr():push("army", {})
	SceneMgr:sharedSceneMgr():push("item", {})
	SceneMgr:sharedSceneMgr():push("main", {})
	SceneMgr:sharedSceneMgr():push("army", {})
	SceneMgr:sharedSceneMgr():push("item", {})

	--[[
	log("\n")
	SceneMgr:sharedSceneMgr():push("main", nil)
	SceneMgr:sharedSceneMgr():push("item", nil)
	SceneMgr:sharedSceneMgr():push("army", nil)

	local mc = MainScene:create()
	local ac = ArmyScene:create({name = "aaaaarrrrrmmmmmyyyy"})
	local ic = ItemScene:create()

	log("\n")
	mc:test()
	ac:test()
	ic:test()

	log("\n")
	log(mc.name)
	log(ac.name)
	log(ic.name)

	log("\n")
	log(mc:getName())
	log(ac:getName())
	log(ic:getName())

	mc:setName("mmmmmmm")

	log("\n")
	log(mc.name)
	log(ac.name)
	log(ic.name)

	log("\n")
	log(mc:getName())
	log(ac:getName())
	log(ic:getName())

	log("\n")
	SceneMgr:sharedSceneMgr():pop()
	SceneMgr:sharedSceneMgr():pop()
	SceneMgr:sharedSceneMgr():pop()
	]]
end

function _G_TRACEBACK_(msg)
	log("========================= trace back info ============================")
	log("== Massage : "..msg)
	log("== Traceback : "..debug.traceback())
	log("=======================================================================")
end

xpcall(main, _G_TRACEBACK_)
