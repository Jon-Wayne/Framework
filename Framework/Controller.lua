-----------------------------------------------------------------------------------------------------
-----
-----  controller base class, all controllers should inherit this class.
-----
-----------------------------------------------------------------------------------------------------

Controller = {}

function Controller:create(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	-- variable:
	o.name = o.name or "Controller"
	o.scene = CCScene:create()
	o.scene:retain()

	log("Controller:create")

	return o
end

function Controller:destroy()
	self.scene:release()
	log("Controller:destroy")
end

--[[
	child class must override this function to get controller instance.
]]
function Controller:getCreateHandler()
	
end

function Controller:isRemoveBefore()
	return true
end

function Controller:getName()
	return self.name
end

function Controller:expectedEvents()
	return nil
end

function Controller:handleEvent(event, data)
	
end

function Controller:dispatchEvent(event, data)
	EventMgr:sharedEventMgr():dispatchEvent(event, data)
end

function Controller:reset()

end

function Controller:refresh()

end

function Controller:loadCCBScene(ccbFileName)
	local ccbReader = CCBReader:create()
	local scene = ccbReader:createSceneWithNodeGraphFromFile(ccbFileName)
	self:sceneAdpat(scene)
	self.scene:addChild(scene)

	local topNode = scene:getChildren():objectAtIndex(0)
	tolua.cast(topNode,"CCGameLayer")

	return topNode
end

function Controller:sceneAdpat(scene)
	if not scene then  
		return
	end

	local gameLayer = scene:getChildren():objectAtIndex(0)
	tolua.cast(gameLayer,"CCGameLayer")

	local scaleX = CCEGLView:sharedOpenGLView():getScaleX()
	local scaleY = CCEGLView:sharedOpenGLView():getScaleY()
	local x1 = CCEGLView:sharedOpenGLView():getFrameSize().width/(scaleY)
	local y1 = CCEGLView:sharedOpenGLView():getFrameSize().height/(scaleX)
	
	if scaleX > scaleY then
		log("ipad layout")
        scene:setScaleX(scaleY/scaleX)
        local fillBarLeft  =  CCSprite:createWithTexture(CCTextureCache:sharedTextureCache():addImage("Fill.png"))
		local fillBarRight =  CCSprite:createWithTexture(CCTextureCache:sharedTextureCache():addImage("Fill.png"))
		local tempX = fillBarRight:getContentSize().width/2

		fillBarRight:setPosition(ccp(320+tempX-15,240))
		fillBarLeft:setPosition(ccp(-tempX+15,240))
		fillBarLeft:setFlipX(true)

		local tempScaleX = 22/fillBarRight:getContentSize().width
		local tempScaleY = 480/fillBarRight:getContentSize().height
		fillBarRight:setScaleX(tempScaleX)
		fillBarRight:setScaleY(tempScaleY)
		fillBarLeft:setScaleX(tempScaleX)
		fillBarLeft:setScaleY(tempScaleY)

		scene:addChild(fillBarLeft,64,64)
		scene:addChild(fillBarRight,64,63)
	elseif scaleX < scaleY then
		log("iphone 5 layout")
		gameLayer:setScaleY(scaleX/scaleY)
		local UpLayer = gameLayer.UpLayer if not UpLayer then UpLayer = gameLayer:getChildByTag(1) end 
		local DownLayer = gameLayer.DownLayer if not DownLayer then DownLayer = gameLayer:getChildByTag(3) end 
		if UpLayer then
			if y1 >= 480 then
				local orignY = UpLayer:getPositionY()
		    	UpLayer:setPositionY(orignY+(y1 - 480)/2)
		    	local PostionY =  UpLayer:getPositionY()
			end
			--log("PostionY:"..PostionY)
		end
		if DownLayer then
		    DownLayer:setPositionY((480-y1)/2)
		end
	else
		log("iphone classic layout")
	end
end

function Controller:test()
	log("Controller:test "..self.name)
end
