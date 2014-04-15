-----------------------------------------------------------------------------------------------------
-----
-----	script files execution entrence.
-----	"compile" all lua files, all script files are only loaded one time here.
-----
-----------------------------------------------------------------------------------------------------

-- add Framework lib
require("Framework.lua")

local function main()
	compile("mainScene.lua")
	compile("itemScene.lua")
	compile("armyScene.lua")

	Factory:sharedFactoryMgr():register("main", MainScene:getCreateHandler())
	Factory:sharedFactoryMgr():register("item", ItemScene:getCreateHandler())
	Factory:sharedFactoryMgr():register("army", ArmyScene:getCreateHandler())
	Factory:sharedFactoryMgr():printMap()

	log("\n")
	SceneMgr:sharedSceneMgr():push("main", nil)
	SceneMgr:sharedSceneMgr():push("item", nil)
	SceneMgr:sharedSceneMgr():push("army", nil)
end

function _G_TRACEBACK_(msg)
	log("========================= trace back info ============================")
	log("== Massage : "..msg)
	log("== Traceback : "..debug.traceback())
	log("=======================================================================")
end

xpcall(main, _G_TRACEBACK_)
