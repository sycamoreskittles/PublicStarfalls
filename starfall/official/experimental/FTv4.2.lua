--@name FTv4.2
-- Floating Turret version 4.2
--@author tjohej, sycamore, The808Error
--@server
--@model models/sprops/rectangles/size_1/rect_3x3x3.mdl

-- Made over the course of 10 grueling hours!
-- Last edited: 5/7/26 @3:25M EDT by @sycamore
-- Now fully commented!

-- UPDATE LOG v4.2 --
-- Fixed issue where turret would fire anyway even if the hands weapon was not active
-- Rebound the firing bind to be IN_KEY.ATTACK instead of MOUSE.MOUSE1 to prevent turret from firing while moving forward
-- Added check for "KeepItZeroedCheck" for if the chip should have its pitch locked or not
-- Changed default model to be the smallest basic sprops rectangle (change it to a GMod plastic brick if the model errors)
-- Added check for if the chip should automatically turn invisible (is zero by default)
-- Added an output to the turret to set a sound

-- Set speed
local SPEED = 5

--Declare KeepItZeroedCheck (if zero, it will unlock its pitch, otherwise the pitch stays locked and keeps zero)
local DoKeepItZeroed = 0

--Declare the chip's physics prop
local chipPhys = chip():getPhysicsObject()

--Optionally make the chip turn itself invisible
local DoInvisible=1
if DoInvisible==1 then
    chip():setMaterial("Models/effects/vol_light001")
end
--Optionally set an owner of the chip by SteamID; do note this does not allow the specified player to run commands on this SF
local chipOwner = find.playerBySteamID("STEAM_0:1:580560231")

--[[ // FIX: This code does not work
--Create outputs to a wire turret (Must be spawned separate from this chip)
wire.adjustOutputs( { "TF", "RPM", "SOUNDURL" }, { "normal", "normal", "string" } )

--Declare the output sound
local soundURL = "https://cdn.discordapp.com/attachments/1338783854705512540/1501882116936568974/magnum_stereo1_2.wav?ex=69fdb038&is=69fc5eb8&hm=8e36d620b823393659813180ea16ec0d6794031411399559247eef2039e96d63&"
wire.triggerOutput(chip(),"SOUNDURL",soundURL)
]]

--Disable gravity and enable moving of the chip
chipPhys:enableGravity( false )
chipPhys:enableMotion( true )

--Command reader for setting RPM
hook.add( "PlayerSay", "SetTurretRPM", function( ply, text )
    local cmd_setRPM = "?sf.FTv4.setRPM"
    if(string.startsWith(string.sub(text,1,string.len(cmd_setRPM)+1),cmd_setRPM)) then
        local param_RPM = string.sub(text,string.len(cmd_setRPM)+2)
        print("[FTv3] Successfully set turret RPM to " .. param_RPM .. ".")
        local RPM = 100/param_RPM
        wire.triggerOutput(chip(), "RPM", RPM)
    end
end )

--Command reader for destroying this chip
hook.add( "PlayerSay", "Destroy", function( ply, text )
    local cmd_destroyChip = "?sf.FTv4.destroy"
    if(string.startsWith(string.sub(text,1,string.len(cmd_destroyChip)+1),cmd_destroyChip)) then
        print("[FTv3] Chip destroyed.")
        chip():remove()
    end
end )

-- Do operations (move positions, aim at vectors and detect mouse clicking)
-- Thanks to The808Error for the framework of this function!
timer.create( "float", 0.1, 0, function()
    local ownerPos = chipOwner:getPos()
    local ownerWeapon = chipOwner:getActiveWeapon()
    local oEA = chipOwner:getEyeAngles()
    local ownerEyeAngles = Angle(oEA.p,oEA.y,0)
    -- Do KeepItZeroedCheck; see line 22
    local KeepItZeroed
    if DoKeepItZeroed==1 then
        KeepItZeroed = Angle(0,oEA.y,0)
    else
        KeepItZeroed = Angle(oEA.p,oEA.y,0)
    end
    -- You should have the "Hands" weapon in your loadout; this may cause an error if you do not (I haven't tested and not going to, it's nearly 3 in the morning)
    local hands = chipOwner:getWeapon("none")
    -- Checks if the current held weapon is "Hands". This can be exchanged for other weapons (such as PAC weapons) but it's not recommended
    if( ownerWeapon == hands ) then
        -- Go to a position around the player in a spherical dimension
        -- Thanks to tjohej for this function!
        targetPos = chipOwner:getEyePos() + chipOwner:getEyeTrace().Normal * 25
        chipPhys:setAngles(KeepItZeroed)
        -- Check if the mouse is being pressed, and if so, fire the turret
        if( chipOwner:keyDown(IN_KEY.ATTACK) ) then
            TF = 1
            wire.triggerOutput(chip(),"SOUNDURL",soundURL)
        else
            TF = 0
        end
        wire.triggerOutput(chip(), "TF", TF)
    else
        -- If the weapon being heald is not "Hands", return the chip to the resting position near the owner
        targetPos = Vector(ownerPos.x+20, ownerPos.y+20, ownerPos.z+80)
        chipPhys:setAngles(ownerEyeAngles)
        TF = 0
        wire.triggerOutput(chip(), "TF", TF)
    end
    -- Finish up by setting the velocity to deltaV (deltaX/deltaT) and multiplying it by the speed factor; actual formula at https://en.wikipedia.org/wiki/Velocity
    chipPhys:setVelocity( ( targetPos - chipPhys:getPos() ) * SPEED )
    chipPhys:setMass(1)
end )
