--@name FTv3
--@author tjohej, sycamore, The808Error
--@server
--@model models/hunter/plates/plate.mdl

-- Now credited!

local SPEED = 5
local DISTANCE = 50

local chipPhys = chip():getPhysicsObject()
wire.adjustOutputs( { "TF", "RPM" }, { "normal", "normal" } )
chipPhys:enableGravity( false )
chipPhys:enableMotion( true )

-- Thanks to The808Error for this function's framework!
timer.create( "float", 0.1, 0, function()
    local ownerPos = owner():getPos()
    local ownerWeapon = owner():getActiveWeapon()
    local oEA = owner():getEyeAngles()
    local ownerEyeAngles = Angle(oEA.p, oEA.y, 0)
    local KeepItZeroed =  Angle(0,oEA.y,0)
    local hands = owner():getWeapon("none")
    if( ownerWeapon == hands ) then
      -- Thanks to tjohej for this operation!
        targetPos = owner():getEyePos() + owner():getEyeTrace().Normal * 25
        chipPhys:setAngles(KeepItZeroed)
    else
        targetPos = Vector(ownerPos.x+20, ownerPos.y+20, ownerPos.z+80)
        chipPhys:setAngles(ownerEyeAngles)
        TF = 0
        wire.triggerOutput(chip(), "TF", TF)
    end
    local bombDisarmed
    if( owner():keyDown(MOUSE.MOUSE1) ) then
        TF = 1
        wire.triggerOutput(chip(), "TF", TF)
    else
        TF = 0
        wire.triggerOutput(chip(), "TF", TF)
    end
    local cmd_setRPM = "?sf.FTv3 setRPM"
    chipPhys:setVelocity( ( targetPos - chipPhys:getPos() ) * SPEED )
    chipPhys:setMass(1)
end )
