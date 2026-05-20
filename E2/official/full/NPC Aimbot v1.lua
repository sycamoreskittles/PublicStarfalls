@name NPC Aimbot v0.1
@inputs Target:entity
@inputs On:number
@inputs RangerData:ranger
@outputs TurretFire 
@outputs GimbalAim:vector 
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
"made by sycamore 12/6/25"
