-----------------------------------------------------------------------------------------------------
-----
-----  some utility for lua system, not for game logic and content.
-----
-----------------------------------------------------------------------------------------------------

function log(...)
	print(...)
end

function compile(fileName)
	log("compile file :"..fileName)
	dofile(fileName)
end