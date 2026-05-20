@name Controllable Emplacement Turret
@inputs U:entity
@outputs AV:angle TF E
interval(100)
TF = U:keyAttack1()
AV = U:eyeAngles()
E = U:isValid()
