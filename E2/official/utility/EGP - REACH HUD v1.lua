@name HUD
@inputs FromKeyboard:string Wirelink:wirelink
@persist TargettedPlayer:entity
interval(1000)

-- Do note, while this file *shouldnt* error easy, it does redraw every element every time it does its thing, so it is still CPU intensive. If you want to recode it to work with element updating, go right ahead.

if(Wirelink:egpConnectedUsers():indexOf(owner())!=0) {
    
} else {
    Wirelink:egpHudEnable(1)
    Wirelink:entity():noCollideAll(1)
}
HEALTHTXTINPUT = ("+" + owner():health())
Wirelink:egpClear()
"CROSSHAIR"
CROSSHAIR = Wirelink:egpText(9000,"+",vec2(1271,703))
CROSSHAIR:setColor(vec4(34,74,255,255))
CROSSHAIR:setText("+","arial",35)

"ARMORBOX"
ARMOR = owner():armor()
ARMORBOXBACKLIGHT = Wirelink:egpBox(1,vec2(1350,100),vec2(450,80))
ARMORBOX = Wirelink:egpBox(3,vec2(1350,100),vec2((4.5*ARMOR),80))
ARMORBOXOUTLINE = Wirelink:egpBoxOutline(5,vec2(1350,100),vec2(450,80))
if(ARMOR<=75) {
    ARMORBOXBACKLIGHT:setColor(vec4(242,233,114,128))
    ARMORBOX:setColor(vec4(242,233,114,128))
    ARMORBOXOUTLINE:setColor(vec4(242,233,114,200))
}
if(ARMOR<75&ARMOR>=20) {
    ARMORBOXBACKLIGHT:setColor(vec4(227,148,64,128))
    ARMORBOX:setColor(vec4(227,148,64,128))
    ARMORBOXOUTLINE:setColor(vec4(227,148,64,200))
}
if(ARMOR<20) {
    ARMORBOXBACKLIGHT:setColor(vec4(216,70,70,128))
    ARMORBOX:setColor(vec4(216,70,70,128))
    ARMORBOXOUTLINE:setColor(vec4(216,70,70,200))
} elseif(ARMOR==0) {
    ARMORBOXBACKLIGHT:setColor(vec4(216,70,70,0))
}
if(ARMOR>75) {
    ARMORBOXBACKLIGHT:setColor(vec4(120,197,242,128))
    ARMORBOX:setColor(vec4(120,197,242,128))
    ARMORBOXOUTLINE:setColor(vec4(120,197,242,200))
}
"HEALTHBOX"
HEALTH = owner():health()
HEALTHBOX = Wirelink:egpBox(2,vec2(1350,125),vec2((3.5*HEALTH),30))
if(HEALTH<=75) {
    HEALTHBOX:setColor(vec4(242,233,114,200))
}
if(HEALTH<75&HEALTH>=20) {
    HEALTHBOX:setColor(vec4(227,148,64,200))
}
if(HEALTH<20) {
    HEALTHBOX:setColor(vec4(216,70,70,200))
}
if(HEALTH>75) {
    HEALTHBOX:setColor(vec4(120,197,242,200))
}

"WEAPONS"
WEAPONS = owner():weapons()
