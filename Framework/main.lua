-----------------------------------------------------------------------------------------------------
-----
-----	script files execution entrence.
-----	"compile" all lua files, all script files are only loaded one time here.
-----
-----------------------------------------------------------------------------------------------------

dofile("Utility.lua")

function _G_TRACEBACK_(msg)
	log("========================= trace back info ============================")
	log("== Massage : "..msg)
	log("== Traceback : "..debug.traceback())
	log("=======================================================================")
end

local function main()
	compile("Controller.lua")

	log("\n")
	log(Controller:getName())

	log("\n")
	local a = Controller:create()
	log(a:getName())
	a:setName("controller a")
	log(a:getName())

	log("\n")
	local b = Controller:create()
	b:setName("controller b")
	log(b:getName())

	log("\n")
	local c = a:create()
	log(c:getName())
	c:setName("controller c")
	log(c:getName())
end

xpcall(main, _G_TRACEBACK_)
