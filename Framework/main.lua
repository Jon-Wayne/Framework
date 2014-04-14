-----------------------------------------------------------------------------------------------------
-----
-----	script files execution entrence.
-----	"compile" all lua files, all script files are only loaded one time here.
-----
-----------------------------------------------------------------------------------------------------

dofile("Utility.lua")

local _G_TRACEBACK_(msg)
	log("========================= trace back info ============================")
	log("== Massage : "..msg)
	log("== Traceback : "..debug.traceback())
	log("=======================================================================")
end

local function main()
	compile("Controller.lua")
end

xpcall(main, _G_TRACEBACK_)