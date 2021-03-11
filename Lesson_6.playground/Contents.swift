import UIKit
import Foundation
//домашняя работа
/*
1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.

*/

// 1 - Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
struct InQueue<Element: Equatable> {
    var queue = [Element]()
    
    mutating func addLast(surname: Element) {
        queue.append(surname)
    }
    
    mutating func deleteMiddle(surname: Element)  {
        var i = self.queue.count - 1
        while i >= 0 {
            if(self.queue[i] == surname){
                self.queue.remove(at: i)
            }
            i -= 1
        }
    }
    
    mutating func deleteLast() {
        queue.removeLast()
        
    }
    
    //3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
    subscript(idx:Int) -> Element? {
        if(idx < self.queue.count) {
            return self.queue[idx]
        }else {
            return nil
        }
    }
}

    
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
func FilterQueue<T> (in array: inout [T], function: (Int) -> Bool ) -> [T] {
    var newFilterQueue = array
    var iD = newFilterQueue.count - 1
    while iD >= 0 {
        if function(iD) {
            newFilterQueue.remove(at: iD)
        }
        iD -= 1
    }
    
    return newFilterQueue
}

func FilterAddSurnameInTheMiddle<T>(whom surname: T, in array: inout [T], function: (Int) -> Int ) -> [T] {
    var newQueue = array
    if (function(newQueue.count) > 0) {
        newQueue.insert(surname, at: function(newQueue.count))
    }
    return newQueue
}


//Вывод на Экран
var line = InQueue<String>()
line.addLast(surname:"Иванов")
line.addLast(surname:"Петров")
line.addLast(surname:"Сидоров")
line.addLast(surname:"Жуков")
print("1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.\n")
print("Очередь сформировалась: \(line.queue)")
line.deleteMiddle(surname: "Петров")
print("Очередь сформировалась после ухода человека: \(line.queue)")

line.deleteLast()
print("Очередь сформировалась после ухода КРАЙНЕГО человека: \(line.queue)")




print("\n2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)\n")

line.addLast(surname:"Петров")
line.addLast(surname:"Жуков")

print("2.1. Очередь сформировалась: \(line.queue)")
print("Очередь с фильтром: \(FilterQueue(in: &line.queue, function: {(i: Int) -> Bool in return i == 2 })) \n")

print("2.2. Очередь сформировалась: \(line.queue)")
print("Очередь с фильтром, где новый человек стоит в середине: \(FilterAddSurnameInTheMiddle(whom: "Кузнецова", in: &line.queue, function: {(i: Int) -> Int in return i/2 }))")
    
 
let NumberInQueue = [
    1: "Первый",
    2: "Второй",
    3: "Третий",
    4: "Четвертый",
    5: "Пятый",
    6: "Шестой",
    7: "Седьмой",
    8: "Восьмой",
    9: "Девятый",
    10: "Десятый"
]
let lineWithNumbers = line.queue.map({ (element) -> String in
    let element = element
    var finalElement = ""
    var iX : Int = 0

    for (index,intInMass) in line.queue.enumerated(){
        if(intInMass == element){
            iX = index // заполнили корректным индексом
            break
        }
    }
    
    finalElement = NumberInQueue[iX+1]! + " человек в очереди с фамилией - " + element + finalElement//line.queue[i] + finalElement
     
    return finalElement

})

print("\n2.3.Очередь сформировалась: \(line.queue)")
print("Преобразованная мэппингом очередь: \(lineWithNumbers)")




print("\n3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.\n")



print(line[0])
print(line[1])
print(line[2])
print(line[8])

print("\n\n! P.S. Подскажите, как сделать распаковку опционального типа (не явно,т.к. в случае print(line[8]!) выведет ошибку, и не косвенно через константу if let i1 = line[8], т.к. в этом случае не выведет nil")
//!!! подскажите, как сделать распаковку опционального типа (не явно,т.к. в случае print(line[8]!) выведет ошибку, и не косвенно через константу if let i1 = line[8], т.к. в этом случае не выведет nil
