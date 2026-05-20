@name NPC Sorting Module v0.2
@inputs T1:entity T2:entity T3:entity T4:entity T5:entity T6:entity T7:entity T8:entity T9:entity T10:entity
@outputs Ignore:array TO:entity
@trigger all

"should state off the bat that i had to force some of these to
 let them occur, otherwise it'll hate datatypes not matching"

EntArray = array(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)
"Entity Array; indexes each entity at respective places, this is important"
HPA = array(T1:health(), T2:health(), T3:health(), T4:health(), T5:health(), T6:health(), T7:health(), T8:health(), T9:health(), T10:health())
"HP Array; used for entity health"
MaxIndex = HPA:maxIndex()
"Returns the index of the maximum number in HPA"
STO = EntArray[MaxIndex, entity]
"Sorted Target Output; returns the entity at the index of the max number in HPA. this looks odd
with it having data specification, but E2 calls for it"
TO = STO
"Target Output; required to be a separate value otherwise E2 will return" "Cannot assign type (n) to variable
of type (e)"
Ignore = EntArray
Ignore1 = Ignore:removeEntity(MaxIndex)
"IgnoreArray for the Target Finder, that way it'll try to not target what does not have highest HP"
