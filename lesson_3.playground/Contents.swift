import UIKit
import Foundation




struct PassengerCar {
    //STABLE FEATURE OF A CAR
    var brand : String = "InputCarBrand"    // марка авто
    var model : String = "InputCarModel"    // модель авто
    var year : Int = 0                      // год выпуска
    var cargoVolume : Float = 0.0           // объем багажника
    
    //VARIABLE FEATURE OF A CAR
        var fullCargoVolume: Float = 0.0                // заполненный объем багажника
        var percentageOfFreeSpace : Float = 0.0         // процентный показатель свободного места в багажнике
        var checkStartEngine : Bool = false             // заведен ли двигатель
        var checkOpenWindows : Bool = false             // открыты ли окна
        //var countGasInPerc : Float = 0.0                // кол-ва бензина в процентном соотношении от объема бака
    
    
    init (carBrand : String, carModel : String, carYear : Int, carCargoVolume : Float ) {
        self.brand = carBrand
        self.model = carModel
        self.year = carYear
        self.cargoVolume = carCargoVolume
    }
    

    enum engine_features {
        case start, stop
    }
    enum windows_features {
        case open, close
    }
    enum cargo_features {
        case putIn(item: Float), putOut (item: Float)
    }
    

    mutating func Engine (checkEngine : engine_features) {
        switch checkEngine {
        case .start:
            checkStartEngine = true
            print("Двигатель заведен у \(brand) \(model) \(year) года выпуска")
        default:
            checkStartEngine = false
            print("Двигатель заглушен у \(brand) \(model) \(year) года выпуска")
        }
    }
    
    mutating func Windows (checkWindows : windows_features) {
        switch checkWindows {
        case .open:
            checkOpenWindows = true
            print("Открыты окна у \(brand) \(model) \(year) года выпуска")
        default:
            checkOpenWindows = false
            print("Двигатель заглушен у \(brand) \(model) \(year) года выпуска")
        }
    }
    
    mutating func PutInOutItem (checkItem : cargo_features) {
        switch checkItem {
       
        case .putIn(let item) where item <= (cargoVolume - fullCargoVolume) :
            fullCargoVolume += item
            percentageOfFreeSpace = ((cargoVolume - fullCargoVolume) / cargoVolume) * 100
            print("Груз, объемом \(item) л, успешно загружен в автомобиль \(brand) \(model) \(year) года выпуска.\nОсталось \(percentageOfFreeSpace)% свободного места в багажнике ")
        
        case .putIn(let item) where item > (cargoVolume - fullCargoVolume) :
            percentageOfFreeSpace = ((cargoVolume - fullCargoVolume) / cargoVolume) * 100
            print("Груз, объемом \(item) л, не загружен в автомобиль \(brand) \(model) \(year) года выпуска из-за нехватки места.\nОсталось \(percentageOfFreeSpace)% свободного места в багажнике ")
       
        case .putOut(let item) where item <= fullCargoVolume:
            fullCargoVolume -= item
            percentageOfFreeSpace = ((cargoVolume - fullCargoVolume) / cargoVolume) * 100
            print("Груз, объемом \(item) л, успешно ликвидирован из в автомобиля \(brand) \(model) \(year) года выпуска.\nОсталось \(percentageOfFreeSpace)% свободного места в багажнике ")
        
        case .putOut(let item) where item > fullCargoVolume:
            percentageOfFreeSpace = ((cargoVolume - fullCargoVolume) / cargoVolume) * 100
            print("Груз, объемом \(item) л, успешно не может быть ликвидирован из в автомобиля \(brand) \(model) \(year) года выпуска, так как объем груза превышает значения имеющегося груза или багажника. \nОсталось \(percentageOfFreeSpace)% свободного места в багажнике ")
        
        default:
            checkOpenWindows = false
            print("Ошибка при загрузке/разгрузке груза в автомобиль \(brand) \(model) \(year) года выпуска")
        }
    }
  

}


var auto1 = PassengerCar(carBrand: "BMW", carModel: "X1", carYear: 2015, carCargoVolume: 365)
var auto2 = PassengerCar(carBrand: "Cadillac", carModel: "SRX", carYear: 2012, carCargoVolume: 380)
var auto3 = PassengerCar(carBrand: "Renault", carModel: "Sandero", carYear: 2018, carCargoVolume: 250)

print("Автомобили на стоянке:")
print(auto1)
print(auto2)
print(auto3)
print("\n")
print("Измененные свойства:\n ")
auto1.Engine(checkEngine: .start)
auto2.Windows(checkWindows: .open)
auto3.PutInOutItem(checkItem: .putIn(item: 500))
auto3.PutInOutItem(checkItem: .putIn(item: 180))
auto3.PutInOutItem(checkItem: .putIn(item: 180))
auto3.PutInOutItem(checkItem: .putIn(item: 70))
auto3.PutInOutItem(checkItem: .putOut(item: 150))
auto3.PutInOutItem(checkItem: .putOut(item: 200))
auto3.PutInOutItem(checkItem: .putOut(item: 100))


print("\n")
print("Внимание! Измененные свойства")
print(auto1)
print(auto2)
print(auto3)
