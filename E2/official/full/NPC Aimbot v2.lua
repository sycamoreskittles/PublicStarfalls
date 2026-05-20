@name NPC Aimbot
@inputs Target:entity
@inputs On:number
@inputs RangerData:ranger
@outputs TurretFire 
@outputs GimbalAim:vector 
@outputs TeleportVector:vector
@trigger all 

GimbalAim = Target:massCenter()
RangerEntity = RangerData:entity()
if(Target:isNPC()>0&RangerData:hitWorld()==0&Target:health()>=1&!RangerEntity:isPlayer()) {
    if(RangerEntity:isNPC()>0&On>0) {
        TurretFire=1
    }
} else {
    TurretFire=0
}

BoundX = 32
BoundY = 32
BoundZ = 72
OwnerBounding1 = RangerData:entity()
OwnerBounding2 = OwnerBounding1:owner()
OwnerVector = OwnerBounding2:massCenter()

TeleportVector = vec(OwnerVector:x(),  OwnerVector:y(), OwnerVector:z()+BoundZ)


"made by sycamore 12/7/25"
