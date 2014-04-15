-----------------------------------------------------------------------------------------------------
-----
-----  some basement for lua system, not for game logic and content.
-----
-----------------------------------------------------------------------------------------------------

function log(...)
	print(...)
end

function logTable(table)
	for k,v in pairs(table) do
		log(k.." -----> "..tostring(v))
	end
end

function logMap(map)
	for k,v in pairs(map) do
		log(k,"======>>",v)
		logTable(v)
	end
end

function compile(fileName)
	local fullpath = CCFileUtils:sharedFileUtils():fullPathForFilename(fileName)
	log("compile file :"..fullpath)
	dofile(fullpath)
end