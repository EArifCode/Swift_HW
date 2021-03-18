import Foundation


enum GeneralError : Error {
    case wrongName
    case wrongMark
}

struct Student : Hashable{
    var surname : String
    var name    : String
    
}

struct mark {
    var studentMark : Int
}

class E_journal {


    var class5A = [

        Student(surname: "Петрова", name: "Нина") : mark(studentMark: 5),
        Student(surname: "Кузнецов", name: "Никита") : mark(studentMark: 4),
        Student(surname: "Малинин", name: "Александр") : mark(studentMark: 3),
        Student(surname: "Хрестоматин", name: "Михаил") : mark(studentMark: 6),

    ]
    
    var maxMark = 5
    
    func CheckMarkStudent (SandN : Student) throws {
        guard let stud = class5A[SandN] else {
            throw GeneralError.wrongName
        }
        guard stud.studentMark <= maxMark else {
            throw GeneralError.wrongMark
        }
        
        print("Выбран ученик для почетной доски - \(SandN.name) \(SandN.surname), который(ая) имеет итоговую оценку \(stud.studentMark) ")
    }
    
}

var student1 = Student(surname: "Петрова", name: "Нина")
var student2 = Student(surname: "Кузнецов", name: "Никита")
var student3 = Student(surname: "Малинин", name: "Андрей")
var student4 = Student(surname: "Хрестоматин", name: "Михаил")


//На каждом этаже школы есть доска почета
let BoardOfFame = [
    1 : student1,
    2 : student2,
    3 : student3,
    4 : student4

]


//На каждом этаже школы есть доска почета
func PutOnTheBoard (floor : Int, funcPut : E_journal) throws {
    let names = BoardOfFame[floor] ?? Student(surname: "Некорретная фамилия", name: " и имя")
    
    try funcPut.CheckMarkStudent(SandN: names)
}

do {
    try PutOnTheBoard(floor: 1, funcPut: E_journal())
    
}
catch GeneralError.wrongName{
    print("Такого ученика нет в журнале")
}
catch GeneralError.wrongMark{
    print("Некорректная оценка у ученика")
}
do {
   
    try PutOnTheBoard(floor: 2, funcPut: E_journal())
   
}
catch GeneralError.wrongName{
    print("Такого ученика нет в журнале")
}
catch GeneralError.wrongMark{
    print("Некорректная оценка у ученика")
}
do {
    
    try PutOnTheBoard(floor: 3, funcPut: E_journal())

}
catch GeneralError.wrongName{
    print("Такого ученика нет в журнале")
}
catch GeneralError.wrongMark{
    print("Некорректная оценка у ученика")
}
do {
    
    try PutOnTheBoard(floor: 4, funcPut: E_journal())
}

catch GeneralError.wrongName{
    print("Такого ученика нет в журнале")
}
catch GeneralError.wrongMark{
    print("Некорректная оценка у ученика")
}
