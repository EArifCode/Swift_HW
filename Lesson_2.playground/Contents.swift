import UIKit


//Ввести номер задания на проверку
let task : Int = 7


//Глобальные переменные
var mass = [Int]()

//блок функций----------------------------------------
func Divide2(testingNumber number:  Int) -> Bool{
    let part = number % 2
    var div2 : Bool = false
    if part == 0 {
         div2 = true
    } else {
        div2 = false
    }
    return div2
}
func Divide3(testingNumber number: Int) -> Bool{
    let part = number % 3
    var div2 : Bool = false
    if part == 0 {
         div2 = true
    } else {
        div2 = false
    }
    return div2
}
func DivideGeneral(testingNumber number: Int, divideNumber : Int) -> Bool{
    let part = number % divideNumber
    var div2 : Bool = false
    if part == 0 {
         div2 = true
    } else {
        div2 = false
    }
    return div2
}

func CreateMass(nullMass: inout [Int]){
    for i in 1...100{
        nullMass.append(i)
    }
   
}
func CreateMassFibonachi(nullMass: inout [Int]){
    
    for i in 0...49{
        switch i {
        case 0:
            nullMass.append(0)
        case 1:
            nullMass.append(1)
            
        case _ where i > 1:
            nullMass.append(nullMass[i-1] + nullMass[i-2])
        default:
            break
        }
        
       
    }
    print(nullMass)
}

func CreateMassSimpleDigital_1(nullMass: inout [Int]) {
    
    CreateMass(nullMass: &nullMass) // Заполняем массив от 1 до 100
        
    //Подзадача 6а
    nullMass.remove(at: 0) // Приодим массив к виду [2:100]
    print("Массив в первоначальном представлении")
    print(nullMass)
   
    // Вспомогательные проверочные элементы
    var s1 = nullMass.count
    var s2 = s1
    
    //Подзадача 6b
    var pX = 0  // = 0
    var pNum = nullMass[0] // = 2
    
    
    repeat {
        
        s2 = s1
        
        
        var iNum = 2 + pNum //5
        var iX = 2 + pX //wrong
        
        for (index,intInMass) in nullMass.enumerated(){
            if(intInMass == iNum){
                iX = index // заполнили корректным индексом для iNum
                break
            }
        }
        
       
        
        var nCount = nullMass.count
        
        while iX < nCount {
            if(nullMass[iX] == iNum) {
                nullMass.remove(at: iX)
                iNum += 2
                iX = 2 + pX
                nCount = nullMass.count
                //print(nullMass)
            }
            iX += 1
        }
    
        // Подзадача 6d
        for (ind,inNewMass) in nullMass.enumerated(){
            if(inNewMass > pNum){
                pNum = inNewMass
                pX = ind
               //print("pX = \(pX) pNum = \(pNum)")
               
                //print(nullMass)
                break
            }
            print
        }
        
        s1 = nullMass.count
    } while (s1 != s2)
    
    print("Массив после преобразования:")
    print(nullMass)
}



func CreateMassSimpleDigital_2(nullMass: inout [Int]) {
    
    CreateMass(nullMass: &nullMass) // Заполняем массив от 1 до 100
        
    //Подзадача 6а
    nullMass.remove(at: 0) // Приводим массив к виду [2:100]
    print("Массив в первоначальном представлении")
    print(nullMass)
   
    
    var p = 2
    var pX = 0;
    
        
    repeat {
                  
        var i = nullMass.count - 1
        while i > pX {
            if(DivideGeneral(testingNumber: nullMass[i], divideNumber: p) == true ) {
                nullMass.remove(at: i)
                    
            }
            i -= 1
        }
    
  
        for (ind,inNewMass) in nullMass.enumerated(){
            if(inNewMass > p){
                p = inNewMass
                pX = ind
            
                break
            }
    
        }
 
    } while (p < 10)
    
    
    
    print("Массив после преобразования:")
    print(nullMass)
}
//--------------------------------------------------

// Проверка заданий---------------------------------
switch task {
case 1:
    print("Проверка задания №\(task)")
   //Проверить число
    let digit = 2
    
    if( Divide2(testingNumber: digit) == true){
        print("Число \(digit) - четное")
    }else{
        print("Число \(digit) - нечетное")
    }
case 2:
    print("Проверка задания №\(task)")
    //Проверить число
    let digit = 3
    if( Divide3(testingNumber: digit) == true){
        print("Число \(digit) делится нацело на 3")
    }else{
        print("Число \(digit) не делится нацело на 3")
    }
case 3:
    print("Проверка задания №\(task)")
    CreateMass(nullMass: &mass)
    print(mass)
case 4:
    print("Проверка задания №\(task)")
    print("Массив до изменения: ")
    CreateMass(nullMass: &mass)
    print(mass)
    var i = mass.count - 1
    while i >= 0 {
        if(Divide2(testingNumber: mass[i]) == true || Divide3(testingNumber: mass[i]) == false) {
            mass.remove(at: i)
        }
        i -= 1
    }
    print("Массив после изменения: ")
    print(mass)
case 5:
    print("Проверка задания №\(task)")
    CreateMassFibonachi(nullMass: &mass)
case 6:
    print("Проверка задания №\(task)")
    CreateMassSimpleDigital_1(nullMass: &mass)
case 7:
    print("Проверка задания №\(task-1) - второй вариант")
    CreateMassSimpleDigital_2(nullMass: &mass)
default:
    print("Задания под №\(task) не существует! ")
    break
}

