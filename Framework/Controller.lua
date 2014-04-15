-----------------------------------------------------------------------------------------------------
-----
-----  controller base class, all controllers should inherit this class.
-----
-----------------------------------------------------------------------------------------------------

--[[
	Variable:
	Class static variables are approprite to put in base class,
	but the instence variables should be put in create function,
	because every intance should have its own copy of data struc.
	Otherwise, when to access one variable which is in super
	class but not in child class, every child class will access
	the variable in super class, they will get the same value
	according to __index, the variable is shared actually.

	Function:
	Class function should be defined and declared in base class,
	because the functions should be shared for every instence to
	appear "inheritence".
	Child class can implement its common-name function to override
	the behaiver in base class.
]]
Controller = {}

--[[
	to use "create" function instead of "new" to create a new instance,
	because Lua garbage will be collected automatically by Lua VM,
	the class instance seems like a "autorelease" object.

	to use "self" to be the meta table of new "o", it's convinient to add
	some meta methods into meta table, what more important is child class 
	can get super class using getmetatable() meta method and call some super
	functions.
]]
function Controller:create(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	-- variable:
	o.name = "Controller"

	return o
end

--[[
	child class must override this function to get controller instance.
]]
function Controller:getCreateHandler()
	
end

function Controller:isReleaseBefore()
	return false
end

function Controller:setName(name)
	self.name = name
end

function Controller:getName()
	return self.name
end

function Controller:test()
	log("Controller:test")
end
