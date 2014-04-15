-----------------------------------------------------------------------------------------------------
-----
-----	script files execution entrence.
-----	"compile" all lua files, all script files are only loaded one time here.
-----
-----------------------------------------------------------------------------------------------------

require("Base.lua")

compile("Controller.lua")
compile("Factory.lua")
compile("SceneMgr.lua")
compile("Controller.lua")