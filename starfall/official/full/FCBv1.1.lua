--@name FCBv1.1
-- Floating Chip Base v1.1
--@author tjohej, sycamore, The808Error
--@shared
--@model models/sprops/rectangles/size_1/rect_3x3x3.mdl

--  ________________   _________________    ________________
-- |               |  |                 |  |                |
-- |       ________|  |                 |  |     _____      |
-- |      |           |       __________|  |    |     |    /
-- |      |_____      |      |             |    |     |   /
-- |            |     |      |             |    |_____|  /
-- |       _____|     |      |             |     _____  |
-- |      |           |      |             |    |     |  \
-- |      |           |      |__________   |    |     |   \
-- |      |           |                 |  |    |_____|    \
-- |      |           |                 |  |                |
-- |______|           |_________________|  |________________|
-- Last edited: 5/20/26 @2:00AM EDT by @sycamore
-- Now fully commented!

-- UPDATE LOG v1.1 --
-- Cut off a lot of things from FTv4.2
-- FCB chip now can play a clientside soundfile // FIX: Does not work at the moment
-- Commands have been added for clientside sounds // FIX: Does not work at the moment

if SERVER then

    -- Set speed
    local SPEED = 5
    
    --Declare the chip's physics prop
    local chipPhys = chip():getPhysicsObject()
    
    --Optionally make the chip turn itself invisible
    local DoInvisible=0
    if DoInvisible==1 then
        chip():setMaterial("Models/effects/vol_light001")
    end
    --Optionally set an owner of the chip by SteamID; do note this does not allow the specified player to run commands on this SF
    local chipOwner = owner()
    
    --Disable gravity and enable moving of the chip
    chipPhys:enableGravity( false )
    chipPhys:enableMotion( true )
    
    --Command reader for destroying this chip
    hook.add( "PlayerSay", "Destroy", function( ply, text )
        local cmd_destroyChip = "?sf.FCB.destroy"
        if(string.startsWith(string.sub(text,1,string.len(cmd_destroyChip)+1),cmd_destroyChip)) then
            print("[FCBv1.1] Chip destroyed.")
            chip():remove()
        end
    end )
    --[[ // FIX: Does not work properly; the clientside code has been removed to shorten the script. It may still be found at the bottom of starfall/official/beta/FCBv2.1.
    hook.add( "PlayerSay", "ShutUp", function( ply, text )
        local cmd_ShutUp = "ashjdasldam,nx,m.asx"
        if(string.startsWith(string.sub(text,1,string.len(cmd_ShutUp)+1),cmd_ShutUp)) then
            net.start( "ShutUp" )
            net.writeString( "ShutUp" )
            net.send( SERVER, true )
            print("Sent to server: " .. "nms")
        end
    end )
    ]]
    net.receive("ShutUp",function()
        print("Server recieved")
    end)
    -- Do operations (move around)
    -- Thanks to The808Error for the framework of this function!
    timer.create( "float", 0.1, 0, function()
        local ownerPos = chipOwner:getPos()
        local ownerWeapon = chipOwner:getActiveWeapon()
        local oEA = chipOwner:getEyeAngles()
        local ownerEyeAngles = Angle(oEA.p,oEA.y,0)
        local targetPos = Vector(ownerPos.x+20, ownerPos.y+20, ownerPos.z+80)
        -- Finish up by floating near the owner
        chipPhys:setVelocity( ( targetPos - chipPhys:getPos() ) * SPEED )
        chipPhys:setMass(1)
    end )
end   
