@name teleporter to hell
@inputs Pilot:entity
@outputs Teleport:number TeleportVector:vector SteamIDOwner:string

PilotSteamID = Pilot:steamID()
PilotIDLength = PilotSteamID:length()
SteamIDOwner = "STEAM_0:1:580560231"

if(!(PilotSteamID == SteamIDOwner)&(PilotIDLength > 0)) {
    TeleportVector = vec(0,0,0)
    Teleport = 1
} elseif(PilotSteamID == SteamIDOwner) {
    Teleport = 0
} else {
    Teleport = 0
}
