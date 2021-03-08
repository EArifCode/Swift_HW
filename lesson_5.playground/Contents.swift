
import Foundation

// 0. Перечисления
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

//1. Общие протоколы
protocol CarStableFeatures {
    
    var vType : vichecleType {get}
    var brand : String {get}                        // марка авто
    var model : String {get}                        // модель авто
    var year : Int {get}                            // год выпуска
    var AmountWheels: Int {get}
    var cargoVolume : Float {get}                   // объем багажника
    
    init(brand : String, model : String, year: Int)
    
}

//1.1. Наследование протоколов
protocol CarVariableFearures : CarStableFeatures {
   
    //VARIABLE FEATURE OF A CAR
    var fullCargoVolume: Float {get set}                    // заполненный объем багажника
    var percentageOfFreeSpace : Float {get set}             // процентный показатель свободного места в багажнике
    var checkStartEngine : engine_features {get set}    // заведен ли двигатель
    var checkOpenWindows : windows_features {get set}   // открыты ли окна
}

//2. Расширение протокола
extension CarVariableFearures {
    func PrintInfoShort() -> String{
        return ("\(brand) \(model) \(year) года выпуска ")
    }
    
    func PrintFreeSpace(percentageOfFreeSpace: Float) -> String {
        if cargoVolume > 0.0 {
            return ("Осталось \(String(percentageOfFreeSpace ))% свободного места в багажнике ")
        } else {
            return ("Багажник или прицеп отсутствует")
        }
    }
    
    mutating func Engine (checkEngine : engine_features) {
        switch checkEngine {
        case .start:
            self.checkStartEngine = .start
            print("Двигатель заведен у " + PrintInfoShort())
        default:
            self.checkStartEngine = .stop
            print("Двигатель заглушен у " + PrintInfoShort())
        }
    }
    
    
    mutating func Windows (checkWindows : windows_features) {
            switch checkWindows {
            case .open:
                self.checkOpenWindows = .open
                print("Открыты окна у "  +  PrintInfoShort ())
            default:
                self.checkOpenWindows = .close
                print("Закрыты окна у " +  PrintInfoShort ())
            }
        }
    
       mutating func PutInOutItem (checkItem : cargo_features) {
            switch checkItem {
    
            case .putIn(let item) where item <= (cargoVolume - fullCargoVolume) :
                fullCargoVolume += item
                percentageOfFreeSpace = ((cargoVolume - fullCargoVolume) / cargoVolume) * 100
                print("Груз, объемом \(item) л, успешно загружен в автомобиль " +  PrintInfoShort () + PrintFreeSpace(percentageOfFreeSpace: percentageOfFreeSpace) )
    
            case .putIn(let item) where item > (cargoVolume - fullCargoVolume) :
                percentageOfFreeSpace = ((cargoVolume - fullCargoVolume) / cargoVolume) * 100
                print("Груз, объемом \(item) л, не загружен в автомобиль " +  PrintInfoShort () + " из-за нехватки места." + PrintFreeSpace(percentageOfFreeSpace: percentageOfFreeSpace))
    
            case .putOut(let item) where item <= fullCargoVolume:
                fullCargoVolume -= item
                percentageOfFreeSpace = ((cargoVolume - fullCargoVolume) / cargoVolume) * 100
                print("Груз, объемом \(item) л, успешно ликвидирован из автомобиля " +  PrintInfoShort () + PrintFreeSpace(percentageOfFreeSpace: percentageOfFreeSpace))
    
            case .putOut(let item) where item > fullCargoVolume:
                percentageOfFreeSpace = ((cargoVolume - fullCargoVolume) / cargoVolume) * 100
                print("Груз, объемом \(item) л, не может быть ликвидирован из автомобиля "  +  PrintInfoShort () + ", так как объем груза превышает значения имеющегося груза или багажника." + PrintFreeSpace(percentageOfFreeSpace: percentageOfFreeSpace))
    
            default:
    
                print("Ошибка при загрузке/разгрузке груза в автомобиль " )
            }
        }
}
   

class trunkCar : CarVariableFearures {
    
    //Private
    enum cargoExist : String {
            case yes = "Прицеп есть"
            case no = "Прицеп отсутствует"
        }

    var cargo : cargoExist
    
    //Common
    var fullCargoVolume: Float
    var percentageOfFreeSpace: Float
    var checkStartEngine: engine_features
    var checkOpenWindows: windows_features
    
    
    var vType: vichecleType
    var brand: String
    var model: String
    var year: Int
    var AmountWheels: Int
    var cargoVolume: Float 
  
    
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
    
    //инициализация
    required init(brand: String, model: String, year: Int) {

        self.vType = .trunk
        self.brand = brand
        self.model = model
        self.year = year

        self.fullCargoVolume = 0.0
        self.percentageOfFreeSpace = 100.0
        self.checkStartEngine = .stop
        self.checkOpenWindows = .close

        self.AmountWheels = 12
        self.cargo = .no
        self.cargoVolume = 0.0
        
        }
        
        
    convenience init (brand : String, model : String, year: Int, cargoVolume: Float, AmountWheels : Int){
       
        self.init(brand: brand, model: model, year: year)
        self.cargo = .no                                    // предопределение наличия прицепа
        self.brand = brand
        self.model = model
        self.year = year
        self.FindCargo(cargoVolume: cargoVolume)            //находим есть ли прицеп в зависимости от объема
        self.setAmountWheels(wheels: AmountWheels)          // количество колес (10,12,18  и тд)
        self.vType = .trunk
        
        

    }
    
    
}

//расширение для вывода на экран
extension trunkCar: CustomStringConvertible {
    var description: String {
        if(cargo == .yes && cargoVolume == 0.0){
            return ("\nТекущий автомобиль грузовой марки " + PrintInfoShort () + " \nПараметры:\n1.Наличие прицепа - \(String(cargo.rawValue))\n2.Вместимость прицепа - \(cargoVolume) л. Необходимо указать парамеры объема для прицепа!\n3.Количество колес - \(AmountWheels) \n\nСостояние автомобиля:\n1.Открыты ли окна - \(checkOpenWindows)\n2.Заведен ли двигатель - \(checkStartEngine).\n\nПараметры погрузки:\n1.Укажите параметры прицепа!"+"\n")
        } else if cargo == .no {
            cargoVolume = 0.0
            return ("\nТекущий автомобиль грузовой марки " + PrintInfoShort () + "\nПараметры:\n1.Наличие прицепа - \(String(cargo.rawValue))\n2.Вместимость прицепа - не применимо\n3.Количество колес - \(AmountWheels)\n\nСостояние автомобиля:\n1.Открыты ли окна - \(checkOpenWindows)\n2.Заведен ли двигатель - \(checkStartEngine).\n\nПараметры погрузки:\n1.Погрузка невозможна - прицеп отсутствует" + "\n")
        }else {
            
            return ("\nТекущий автомобиль грузовой марки " + PrintInfoShort () + "\nПараметры:\n1.Наличие прицепа - \(String(cargo.rawValue))\n2.Вместимость прицепа - \(cargoVolume) л.\n3.Количество колес - \(AmountWheels) \n\nСостояние автомобиля:\n1.Открыты ли окна - \(checkOpenWindows)\n2.Заведен ли двигатель - \(checkStartEngine).\n\nПараметры погрузки:\n1."+PrintFreeSpace(percentageOfFreeSpace: percentageOfFreeSpace) + "\n")
        }
    }
}


class PassengerCar : CarVariableFearures {
    //Private
    enum carType {
            case SUV
            case Sedan
            case Hatchback
        }
    //Добавился тип кузова(седан, хэтчбэк, внедорожник)
    var type : carType
    var amountDoors : Int

    
    //Common
    var fullCargoVolume: Float
    var percentageOfFreeSpace: Float
    var checkStartEngine: engine_features
    var checkOpenWindows: windows_features
    var vType: vichecleType
    var brand: String
    var model: String
    var year: Int
    var AmountWheels: Int
    var cargoVolume: Float
    
    func SetAmountDoors (doors : Int) {
        self.amountDoors = doors
    }
    
    required init(brand: String, model: String, year: Int) {
        self.vType = .passenger
        self.brand = brand
        self.model = model
        self.year = year

        self.fullCargoVolume = 0.0
        self.percentageOfFreeSpace = 100.0
        self.checkStartEngine = .stop
        self.checkOpenWindows = .close

        self.AmountWheels = 4
        self.cargoVolume = 0.0
        self.type = .Hatchback
        self.amountDoors = 5
    }
    convenience init(type: carType, brand : String, model : String, year: Int, doors: Int){
        self.init(brand: brand, model: model, year: year)
        self.type = type
        self.brand = brand
        self.model = model
        self.year = year
        self.vType = .passenger
        self.SetAmountDoors (doors: doors)
              
    }
        
}
//расширение для вывода на экран
extension PassengerCar:CustomStringConvertible {
    var description: String {
      
        if(cargoVolume == 0.0) {
           return ("\nТекущий ЛЕГКОВОЙ автомобиль марки " + PrintInfoShort () + "\nПараметры:\n1.Тип кузова - \(type)\n2.Вместимость багажника - Укажите параметры багажника!\n2.Количество дверей - \(amountDoors) \n\nСостояние автомобиля:\n1.Открыты ли окна - \(checkOpenWindows)\n2.Заведен ли двигатель - \(checkStartEngine).\n\nПараметры погрузки:\n1."+PrintFreeSpace(percentageOfFreeSpace: percentageOfFreeSpace) + "\n")
        } else if (cargoVolume > 0.0) {
            return ("\nТекущий ЛЕГКОВОЙ автомобиль марки " + PrintInfoShort () + "\nПараметры:\n1.Тип кузова - \(type)\n2.Вместимость багажника - \(cargoVolume) л.\n2.Количество дверей - \(amountDoors) \n\nСостояние автомобиля:\n1.Открыты ли окна - \(checkOpenWindows)\n2.Заведен ли двигатель - \(checkStartEngine).\n\nПараметры погрузки:\n1."+PrintFreeSpace(percentageOfFreeSpace: percentageOfFreeSpace) + "\n")
        } else {
            return ("\nТекущий ЛЕГКОВОЙ автомобиль марки " + PrintInfoShort () + "\nПараметры:\n1.Тип кузова - \(type)\n2.Вместимость багажника - Неверно указаны параметры багажника! л.\n2.Количество дверей - \(amountDoors) \n\nСостояние автомобиля:\n1.Открыты ли окна - \(checkOpenWindows)\n2.Заведен ли двигатель - \(checkStartEngine).\n\nПараметры погрузки:\n1."+PrintFreeSpace(percentageOfFreeSpace: percentageOfFreeSpace) + "\n")
        }
    }
}

//--------------------------------------------------------------------------------------------------
var trCar = trunkCar(brand: "Honda", model: "CB400", year: 2018, cargoVolume: 0.0, AmountWheels: 16)
trCar.cargo = .yes
trCar.cargoVolume = 600
trCar.checkOpenWindows = .open
trCar.PutInOutItem(checkItem: .putIn(item: 100))
print(trCar)

var trCar2 = trunkCar(brand: "Honda", model: "CB1000", year: 2003, cargoVolume: 1000, AmountWheels: 18)
print(trCar2)

var pasCar = PassengerCar(type: .Hatchback, brand: "Opel", model: "Corsa", year: 2014, doors: 3)
pasCar.checkStartEngine = .start
pasCar.cargoVolume = 250
print(pasCar)

var pasCar2 = PassengerCar(type: .SUV, brand: "Cadillac", model: "SRX", year: 2012, doors: 5)
pasCar2.cargoVolume = 480
pasCar2.PutInOutItem(checkItem: .putIn(item: 300))
pasCar2.PutInOutItem(checkItem: .putOut(item: 120))
pasCar2.checkStartEngine = .start
print(pasCar2)
