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
	compile("itemsScene.lua")
	compile("armyScene.lua")

	
end

function _G_TRACEBACK_(msg)
	log("========================= trace back info ============================")
	log("== Massage : "..msg)
	log("== Traceback : "..debug.traceback())
	log("=======================================================================")
end

xpcall(main, _G_TRACEBACK_)
