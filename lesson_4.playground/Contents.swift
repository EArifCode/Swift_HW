import UIKit
import Foundation

class Vichecles {
    
    enum vichecleType {
        case trunk
        case passenger
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
    
    var vType : vichecleType?
    var brand : String?                     // марка авто
    var model : String?                     // модель авто
    var year : Int?                         // год выпуска
    var AmountWheels: Int = 4
    var cargoVolume : Float = 0.0           // объем багажника
    
    
    
    //VARIABLE FEATURE OF A CAR
    var fullCargoVolume: Float = 0.0                  // заполненный объем багажника
    var percentageOfFreeSpace : Float = 0.0           // процентный показатель свободного места в багажнике
    var checkStartEngine : engine_features = .stop    // заведен ли двигатель
    var checkOpenWindows : windows_features = .close  // открыты ли окна
    //var countGasInPerc : Float = 0.0                // кол-ва бензина в процентном соотношении от объема бака
    
    init() {

        }
    init(vType: vichecleType, brand : String, model : String, year: Int) {
//        self.setType(type: type)
        self.vType = vType
        self.brand = brand
        self.model = model
        self.year = year
    }
    
    func PrintInfo () ->String {
        return ("\(String(brand ?? "No brand")) \(String(model ?? "No Model")) \(Int(year ?? 0000)) года выпуска")
    }
    
    func PrintFreeSpace (percentageOfFreeSpace : Float) ->String {
        if cargoVolume > 0.0 {
            return ("\nОсталось \(String(percentageOfFreeSpace ))% свободного места в багажнике ")
        } else {
            return ("\nБагажник или прицеп отсутствует")
        }
    }
    
    func Engine (checkEngine : engine_features) {
        switch checkEngine {
        case .start:
            self.checkStartEngine = .start
            print("Двигатель заведен у " + PrintInfo())
        default:
            self.checkStartEngine = .stop
            print("Двигатель заглушен у " + PrintInfo())
        }
    }
    
    func Windows (checkWindows : windows_features) {
        switch checkWindows {
        case .open:
            self.checkOpenWindows = .open
            print("Открыты окна у " + PrintInfo())
        default:
            self.checkOpenWindows = .close
            print("Закрыты окна у " + PrintInfo())
        }
    }
    
   func PutInOutItem (checkItem : cargo_features) {
        switch checkItem {
       
        case .putIn(let item) where item <= (cargoVolume - fullCargoVolume) :
            fullCargoVolume += item
            percentageOfFreeSpace = ((cargoVolume - fullCargoVolume) / cargoVolume) * 100
            print("Груз, объемом \(item) л, успешно загружен в автомобиль " + PrintInfo() + PrintFreeSpace(percentageOfFreeSpace: percentageOfFreeSpace) )
        
        case .putIn(let item) where item > (cargoVolume - fullCargoVolume) :
            percentageOfFreeSpace = ((cargoVolume - fullCargoVolume) / cargoVolume) * 100
            print("Груз, объемом \(item) л, не загружен в автомобиль " + PrintInfo() + " из-за нехватки места." + PrintFreeSpace(percentageOfFreeSpace: percentageOfFreeSpace))
       
        case .putOut(let item) where item <= fullCargoVolume:
            fullCargoVolume -= item
            percentageOfFreeSpace = ((cargoVolume - fullCargoVolume) / cargoVolume) * 100
            print("Груз, объемом \(item) л, успешно ликвидирован из автомобиля " + PrintInfo() + PrintFreeSpace(percentageOfFreeSpace: percentageOfFreeSpace))
        
        case .putOut(let item) where item > fullCargoVolume:
            percentageOfFreeSpace = ((cargoVolume - fullCargoVolume) / cargoVolume) * 100
            print("Груз, объемом \(item) л, не может быть ликвидирован из автомобиля " + PrintInfo() + ", так как объем груза превышает значения имеющегося груза или багажника." + PrintFreeSpace(percentageOfFreeSpace: percentageOfFreeSpace))
        
        default:
            
            print("Ошибка при загрузке/разгрузке груза в автомобиль " + PrintInfo())
        }
    }
}



//-------------------------------------------
class TrunkCar: Vichecles {
    enum cargoExist {
        case yes
        case no
    }
    
   
    var cargo : cargoExist
    
    //кол-во колес
    func setAmountWheels (wheels : Int) {
        self.AmountWheels = wheels
    }
    
    //находим есть ли прицеп в зависимости от объема
    func FindCargo (cargoVolume: Float) {
        switch cargoVolume {
        case _ where cargoVolume <= 0.0:
            self.cargoVolume = 0.0
            self.cargo = .no
        default:
            self.cargoVolume = cargoVolume
            self.cargo = .yes
        }
    }
    
    init(brand : String, model : String, year: Int, cargoVolume: Float, AmountWheels : Int){
     
        self.cargo = .no                            // предопределение наличия прицепа
        super.init()
        self.brand = brand
        self.model = model
        self.year = year
        self.FindCargo(cargoVolume: cargoVolume)    //находим есть ли прицеп в зависимости от объема
        self.setAmountWheels(wheels: AmountWheels)  // количество колес (10,12,18  и тд)
        self.vType = .trunk
        print(self.PrintInfo())                     // печать общей информации о машине
        
        
    }
    
    
    
}

//-------------------------------------------
class PassegerCar : Vichecles {
    
    enum carType {
        case SUV
        case Sedan
        case Hatchback
    }

    var type : carType
    
    //Добавился тип кузова(седан, хэтчбэк, внедорожник)
    init(type: carType, brand : String, model : String, year: Int){
        self.type = type
        super.init()
        self.brand = brand
        self.model = model
        self.year = year
        self.vType = .passenger
        print(self.PrintInfo())                     // печать общей информации о машине
        
    }
}


print("//---------------------------- \n")
print("Определяем пассажирскую машину \n")
print("//---------------------------- \n")
var car1 = PassegerCar( type: .SUV, brand: "BMW", model: "X1", year: 2015)
print("\n 1. Провера текущего состояния двигателя:")
print(car1.checkStartEngine)
print("\n 2. Заведем двигатель:")
car1.Engine(checkEngine: .start)
print(car1.checkStartEngine)
print("\n 3. Заглушим двигатель:")
car1.Engine(checkEngine: .stop)
print(car1.checkStartEngine)

print("\n 4. Провека марки авто:")
print(car1.brand!)


print("\n 5. Погрузка груза:")
car1.PutInOutItem(checkItem: .putIn(item: 100))

car1.cargoVolume = 300.0
print("     5.1. Установление параметров объема багажника - \(car1.cargoVolume) л")
car1.PutInOutItem(checkItem: .putIn(item: 100))
car1.PutInOutItem(checkItem: .putOut(item: 400))
car1.PutInOutItem(checkItem: .putOut(item: 50))

print("\n 6. Проверка окон:")
print(car1.checkOpenWindows)
print("     6.1 Откроем окна:")
car1.Windows(checkWindows: .open)

print("\n 7. Определение типа машины и является ли она грузовой:")
print(car1.vType!)
print(car1.type)
print("\n 8. Определение кол-вa колес:")
print(car1.AmountWheels)

print("\n\n//---------------------------- \n")
print("Определяем грузовую машину \n")
print("//---------------------------- \n")
var car2 = TrunkCar( brand: "Honda" , model: "CiV", year: 2020, cargoVolume: 1000, AmountWheels: 18)
print("\n 1. Провера текущего состояния двигателя:")
print(car2.checkStartEngine)
print("\n 2. Заведем двигатель:")
car2.Engine(checkEngine: .start)
print(car2.checkStartEngine)
print("\n 3. Заглушим двигатель:")
car2.Engine(checkEngine: .stop)
print(car2.checkStartEngine)
print("\n 4. Есть ли прицеп:")
print(car2.cargo)
print("\n 5. Объем прицепа в литрах:")
print(car2.cargoVolume)
print("\n 5. Определение типа машины и является ли она грузовой:")
print(car2.vType!)
print("\n 6. Погрузка груза:")
car2.PutInOutItem(checkItem: .putIn(item: 100))
print("\n 7. Определение кол-вa колес:")
print(car2.AmountWheels)

print("\n\n//---------------------------- \n")
print("Определяем 2-ю грузовую машину \n")
print("//---------------------------- \n")

var car3 = TrunkCar( brand: "Honda" , model: "CiV2010", year: 2010, cargoVolume: 0.0, AmountWheels: 12)
print("\n 1. Есть ли прицеп:")
print(car3.cargo)
print("\n 2. Объем прицепа в литрах:")
print(car3.cargoVolume)

print("\n 3. Проверка окон:")
print(car3.checkOpenWindows)
print("     3.1 Откроем окна:")
car3.Windows(checkWindows: .open)
print("\n 4. Погрузка груза:")
car3.PutInOutItem(checkItem: .putIn(item: 100))
print("\n 5. Определение типа машины и является ли она грузовой:")
print(car3.vType!)
print("\n 6. Определение кол-вa колес:")
print(car3.AmountWheels)
