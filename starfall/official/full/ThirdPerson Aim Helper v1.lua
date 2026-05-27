--@name ThirdPerson Aim Helper v1
--@author sycamore
// Wrote this all on my own!
--@shared
--@model models/fasteroid/plugs/sd_card.mdl

if CLIENT then
    function getEyetraceHit ( ent )
        local eyetrace = ent:getEyeTrace().HitPos
        return eyetrace
    end
    
    function createHolo( ent, model, scale )
        if hologram.canSpawn() then
            local func_createholo = hologram.create(ent:getPos(), ent:getAngles(), model, scale)
            print( "Successfully created hologram!" )
            return func_createholo
        else
            print( "You cannot create anymore holograms! Try deleting whatever is creating any." )
            return ent
        end
    end
    local this = chip()
    local thisO = this:getOwner()
    
    local holomodel = "models/sprops/rectangles/size_1/rect_3x3x3.mdl"
    holo = createHolo( this, holomodel )
    
    local colorstruct = Vector(255,0,0)
    
    timer.create("think", 0.01, 0, function()
        holo:setPos(getEyetraceHit(thisO))
        holo:setColor(colorstruct:getColor())
        holo:setMaterial("models/debug/debugwhite")
        holo:suppressEngineLighting( true )
    end )
end
