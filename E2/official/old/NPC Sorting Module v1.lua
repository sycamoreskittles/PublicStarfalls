@name NPC Sorting Module
@inputs Targ1:entity Targ2:entity Targ3:entity Targ4:entity Targ5:entity Targ6:entity Targ7:entity Targ8:entity Targ9:entity Targ10:entity
@outputs SortedTarget:entity
@outputs Ignore:array

HPT1 = Targ1:health()
HPT2 = Targ2:health()
HPT3 = Targ3:health()
HPT4 = Targ4:health()
HPT5 = Targ5:health()
HPT6 = Targ6:health()
HPT7 = Targ7:health()
HPT8 = Targ8:health()
HPT9 = Targ9:health()
HPT10 = Targ10:health()
Max1 = max(HPT1, HPT2, HPT3, HPT4)
Max2 = max(HPT5, HPT6, HPT7, HPT8)
-- HOLY CHECKSUM OF DOOM
if(HPT1 == max(Max1, Max2, HPT9, HPT10)) {
    SortedTarget = Targ1
    Ignore = array(Targ2, Targ3, Targ4, Targ5, Targ6, Targ7, Targ8, Targ9, Targ10)
}
if(HPT2 == max(Max1, Max2, HPT9, HPT10)) {
    SortedTarget = Targ2
    Ignore = array(Targ1, Targ3, Targ4, Targ5, Targ6, Targ7, Targ8, Targ9, Targ10)
}
if(HPT3 == max(Max1, Max2, HPT9, HPT10)) {
    SortedTarget = Targ3
    Ignore = array(Targ1, Targ2, Targ4, Targ5, Targ6, Targ7, Targ8, Targ9, Targ10)
}
if(HPT4 == max(Max1, Max2, HPT9, HPT10)) {
    SortedTarget = Targ4
    Ignore = array(Targ1, Targ2, Targ3, Targ5, Targ6, Targ7, Targ8, Targ9, Targ10)
}
if(HPT5 == max(Max1, Max2, HPT9, HPT10)) {
    SortedTarget = Targ5
    Ignore = array(Targ1, Targ2, Targ3, Targ4, Targ6, Targ7, Targ8, Targ9, Targ10)
}
if(HPT6 == max(Max1, Max2, HPT9, HPT10)) {
    SortedTarget = Targ6
    Ignore = array(Targ1, Targ2, Targ3, Targ4, Targ5, Targ7, Targ8, Targ9, Targ10)
}
if(HPT7 == max(Max1, Max2, HPT9, HPT10)) {
    SortedTarget = Targ7
    Ignore = array(Targ1, Targ2, Targ3, Targ4, Targ5, Targ6, Targ8, Targ9, Targ10)
}
if(HPT8 == max(Max1, Max2, HPT9, HPT10)) {
    SortedTarget = Targ8
    Ignore = array(Targ1, Targ2, Targ3, Targ4, Targ5, Targ6, Targ7, Targ9, Targ10)
}
if(HPT9 == max(Max1, Max2, HPT9, HPT10)) {
    SortedTarget = Targ9
    Ignore = array(Targ1, Targ2, Targ3, Targ4, Targ5, Targ6, Targ7, Targ8, Targ10)
}
if(HPT10 == max(Max1, Max2, HPT9, HPT10)) {
    SortedTarget = Targ10
    Ignore = array(Targ1, Targ2, Targ3, Targ4, Targ5, Targ6, Targ7, Targ8, Targ9)
}

"made by sycamore 12/22/25"
