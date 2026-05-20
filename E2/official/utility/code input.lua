@name Code Input
@inputs FromKeyboard:string
@outputs ToDoor:number ToScreen:string

Inputs = FromKeyboard
Password = "Fuckingpassword"

if(Inputs == Password) {
    ToScreen = "Correct!"
    ToDoor = 1
}
if((!(Inputs == Password))|(!(Inputs == ""))) {
    ToScreen = "Wrong. Try again."
    ToDoor = 0
}
if(Inputs == "") {
    ToScreen = "Press E on the keyboard below."
    ToDoor = 0
}

"made by sycamoreskittles 12/24/25"
