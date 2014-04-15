-----------------------------------------------------------------------------------------------------
-----
-----  some basement for lua system, not for game logic and content.
-----
-----------------------------------------------------------------------------------------------------

function log(...)
	print(...)
end

function compile(fileName)
	local fullpath = CCFileUtils:sharedFileUtils():fullPathForFilename(fileName)
	log("compile file :"..fullpath)
	dofile(fullpath)
end