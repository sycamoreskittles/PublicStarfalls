--@name AT-Zv1
--@author sycamore, Victor Skull
--@server
--@model models/sprops/rectangles/size_1/rect_3x3x3.mdl

// This is a beta! May have offbeat functions, comments, etc. Not guranteed to have a smooth experience, or work properly.

// DO: comment this whole sucker

-- Declare the inputs from a wire Target Finder
wire.adjustInputs( { "RNGR_HIT" }, { "normal" } )
-- Declare an output to the turret
wire.adjustOutputs( { "TF", "RPM", "SPRD", "DLY", "RNGR" }, { "normal","normal","normal","normal","normal" } )

-- Declare the settings table 
    -- 1 is the vector for offset; changing could result in getting shot
    -- 2 is the range of how far out the chip should search
    local settings = { Vector(0,0,100), 500 }
    wire.triggerOutput(chip(), "RNGR", settings[2])

-- Define command readers
// DO: do this later, make the turret work on its own first
    
-- Define the chip's physics prop, and its internal identifier
local this = chip()
local thisProp = this:getPhysicsObject()

--Command reader for destroying this chip
hook.add( "PlayerSay", "Destroy", function( ply, text )
    local cmd_destroyChip = "?sf.AT-Z.destroy"
    if(string.startsWith(string.sub(text,1,string.len(cmd_destroyChip)+1),cmd_destroyChip)) then
        print("[AT-Zv1] Chip destroyed.")
        chip():remove()
    end
end )

--Command reader for disabling/enabling movement
--[[ // FIX: for some reason, does not work properly. fuck this shit, i've been trying to make it work for the past two hours with no luck
local frozen
hook.add( "PlayerSay", "Freeze", function( ply, text )
    local cmd_freezeChip = "freeze"
    if frozen == nil then
        frozen = false
    end
    if(string.startsWith(string.sub(text,1,string.len(cmd_freezeChip)+1),cmd_freezeChip)) then
        -- Make sure "frozen" is not nil
        frozen = !frozen
        if frozen == false then
            thisProp:enableMotion( true )
            print( "[AT-Zv1]: Chip unfrozen.")
            frozen = true 
        elseif frozen == true then
            thisProp:setAngles(Angle(0,0,0))
            thisProp:enableMotion( false )
            print( "[AT-Zv1]: Chip frozen." )
        end
    end
end )
]]
--Command reader for resetting angles
hook.add( "PlayerSay", "AngleFix", function( ply, text )
    local cmd_anglefix = "?sf.AT-Z.fixangs"
    local i=0
    if(string.startsWith(string.sub(text,1,string.len(cmd_anglefix)+1),cmd_anglefix)) then
        print( "[AT-Z]: Trying to fix angles..." )
        timer.create( "FixAngles", 1, 3, function()
            i=i+1
            print("[AT-Z]: Step " .. i .. "...")
            if timer.repsleft("FixAngles") == 2 then
                thisProp:enableMotion( false )
            elseif timer.repsleft("FixAngles") == 1 then
                thisProp:enableMotion( true )
            else
                thisProp:setAngles(Angle(0,0,0))
            end
        end )
    end
end )

-- Prepare some things
thisProp:enableGravity( false )
thisProp:enableMotion( true ) // VAR: Can be changed
thisProp:setMass(1)
local SPEED = 5

// You could set an owner here, but in the future the turret may orbit the selected entity (in order to kill it)
local chipOwner = owner()

-- Do entity calculations
timer.create( "Think", 0.1, 0, function()
    local NPCs = find.inSphere(thisProp:getPos(), settings[2], function( ent )
        return ent:isNPC()
    end )
    local NPCsSorted = find.sortByClosest(NPCs, thisProp:getPos())
    if not table.isEmpty(NPCsSorted) then
        local Target = NPCsSorted[1]:getPos():getAngle()
        thisProp:setAngles(Target)
        if NPCsSorted[1]:isValid() then
            wire.triggerOutput(this, "TF", 1)
        end
    else
        local ang = Angle(0,0,0) // DEBUG: got tired of retyping oEA or 0,0,0 fuck this bro oh my god
        thisProp:setAngles(ang)
    end
    printTable(NPCsSorted)
end )

-- Declare the "offset" vector (may be changed but is ill-advised as the turret could just shoot you)
local offset = Vector(0,0,100)
-- Do floating operations
timer.create( "Float", 0.1, 0, function()
    // FORK: Grabbed this from FCBv1.1
    local ownerPos = chipOwner:getPos()
    local ownerWeapon = chipOwner:getActiveWeapon()
    local oEA = chipOwner:getEyeAngles()
    local ownerEyeAngles = Angle(0,0,0)
    local targetPos = Vector(ownerPos.x+settings[1].x, ownerPos.y+settings[1].y, ownerPos.z+settings[1].z)
    -- Finish up by floating near the owner
    thisProp:setVelocity( ( targetPos - thisProp:getPos() ) * SPEED )
end )
