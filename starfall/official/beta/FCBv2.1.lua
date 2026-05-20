--@name FCBv2.1
-- Floating Chip Base v2.1
--@author tjohej, sycamore, The808Error
--@shared
--@model models/sprops/rectangles/size_1/rect_3x3x3.mdl

// This is a beta! May have offbeat functions, comments, etc. Not guranteed to have a smooth experience, or work properly.

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
-- Last edited: 5/20/26 @1:30AM EDT by @sycamore
-- Now fully commented!

-- UPDATE LOG v2.1
-- Implemented new commenting technique:
    --[[
    Lines starting with // are coder commentary; likely @sycamore (myself)
    e.g.: // FIX: Meant to be a force trigger for a net message, but couldn't get it to work
    
    Lines starting with -- are labels, or the beginning of a decommisioned area of code. If it were possible, I would use //, but it does not work.
    e.g.: -- Set the angles of the chip
    
    Disabled or otherwise decomissioned code are likely areas of code used for debugging (enable at your own risk), or are disabled code for viewing by another coder.
    Additionally, enabling any code with "// FIX:" as the reason of it being commented may give undesirable outcomes. It is not recommended to remove their comment status.
    ]]
-- Recoded the offset to be easily changable, you can now change it with the "offset" variable! (must be vector)
-- Done various code optimizations, such as restricting some unused/debug code
-- Added command for locking the position of the chip (?sf.FTB.lockpos)
-- Added command for setting the destination of the chip to be the owner's center of mass


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
    
    -- Set an offset for the chip in coordinates; this is only for when it follows the player
        -- This also works with negative numbers. Integers are recommended.
        -- This works like: ownerPos.x+offset.x, ownerPos.offset.y, ownerPos.offset.z
    local offset = Vector(20,20,80)
    
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
    
    --[[// FIX: Meant to be a force trigger for a net message, but couldn't get it to work
    hook.add( "PlayerSay", "ShutUp", function( ply, text )
        local cmd_ShutUp = "nms"
        if(string.startsWith(string.sub(text,1,string.len(cmd_ShutUp)+1),cmd_ShutUp)) then
            net.start( "ShutUp" )
            net.send( "ShutUp", true )
            print("Sent to server: " .. "nms")
        end
    end )
    net.receive("ShutUp",function()
        print("Server recieved")
    end)
    ]]
    
    -- Do operations (move around)
    -- Thanks to The808Error for the framework of this function!
    timer.create( "float", 0.1, 0, function()
        local ownerPos = chipOwner:getPos()
        local ownerWeapon = chipOwner:getActiveWeapon()
        local oEA = chipOwner:getEyeAngles()
        local ownerEyeAngles = Angle(oEA.p,oEA.y,0)
        local targetPos = Vector(ownerPos.x+offset.x, ownerPos.y+offset.y, ownerPos.z+offset.z)
        --[[ // FIX: This function does not work properly, find another way to make it work
        if cmd_lockPos != true then
            local targetPos = Vector(ownerPos.x+offset.z, ownerPos.y+offset.z, ownerPos.z+offset.z)
        else
            // The target position never updates, therefore it never moves (in theory). This variable should never be defined as "1" upon spawning.
        end
        ]]
        
        -- Do an operation for offsetting the position of the chip // FIX
        -- local oET = chipOwner:getEyeTrace().Normal

        --[[ // FIX: This function currently doesn't work properly (and causes angles to go nuts)
        -- Do checks for setting positions of oET if it should be below zero
        local targetPos
        targetPos = oEP + oET
        -- Do for X
        if oET.x<0 then
            targetPos.x = targetPos.x-offset.x
        else
            targetPos.x = targetPos.x+offset.x
        end
        -- Do for Y
        if oET.x<0 then
            targetPos.y = targetPos.y-offset.y
        else
            targetPos.y = targetPos.y+offset.y
        end
        -- Do for Z
        if oET.x<0 then
            targetPos.z = targetPos.z-offset.z
        else
            targetPos.z = targetPos.z+offset.z
        end
        ]]
        -- Finish up by floating near the owner
        chipPhys:setVelocity( ( targetPos - chipPhys:getPos() ) * SPEED )
        chipPhys:setMass(1)
    end )
end    

if CLIENT then
    --[[ // FIX: this does not work, either for some user error on my part or otherwise; if anyone wants to take a stab at this go ahead
    local soundURL = "https://cdn.discordapp.com/attachments/945396659649675305/1502134211547631647/Evilution.wav?ex=69fe9b00&is=69fd4980&hm=ad5a956fc6e0c16d6b064047e11e710205ac99d206e3b040ffa07684618a1d63&"
    net.receive("playSnd", function()
        local url = net.readString(soundURL)
        
        bass.loadURL(url, "3d mono", function(Bass, err, name)
            Bass:play()
        end)
    end)
    net.receive("ShutUp",function()
        print("God Fucking Damnit")
    end)
    ]]
end
