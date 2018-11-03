import UIKit


var str = "Hello, movile next"

//
/*
 
 /*
 Swift accepts commentary inside commentary
 */
 
*/

// Optional + Command + / = generates func doc struct
/// O método jurubeba soma dois Ints e retona o resultado
///
/// - Parameters:
///   - a: Operando do lado esquerdo da soma dos inteiros
///   - b: Operando do lado direito da soma dos inteiros
/// - Returns: Soma dos inteiros
func jurubeba(a: Int, b: Int) -> Int {
    return a + b
}

// Int32, Int64, Int = Int infers it by the system achitecture
Int32.max
Int32.min

//Tuplas

let tuple = (1, "Hu3", 3.5)
tuple.1

let namedTuple: (age: Int, name: String, salary: Double) = (21, "Valmir", 0.0)
namedTuple.name

let addressNumber: Int = Int("111")! // Jeito vida loka

if let addressNumber = Int("111") {
    print(addressNumber)
}

// Operador de coalescencia nula
let addressNum: Int = Int("111") ?? 0

// Operators pre fix, in fix and pos fix

// rhs right side
prefix operator >-
prefix func >-(rhs: Int) -> Int {
    return rhs * rhs
}

>-8


// rhs right side
postfix operator ❕
postfix func ❕(lhs: Int) -> Int {
    return lhs * lhs
}

10❕


infix operator >-<
func >-<(lhs: Int, rhs: Int) -> [Int]? {
    
    if lhs > rhs {
        return nil
    }
    
    var numbers: [Int] = []
    for _ in 1...lhs {
        var randomNumber = Int.random(in: 1...rhs)
        
        while numbers.contains(randomNumber) {
            randomNumber = Int.random(in: 1...rhs)
        }
        
        numbers.append(randomNumber)
    }
    
    return numbers.sorted()
}

6>-<6


struct Next: Hashable {
    let couseName: String
    let duration: Int
}

// dictionaries needs key hashable
let dict: [Next: String] = [:]


// set does not accept equal elements
// can check if one set is inserted in another
// set does not is infered by compiler, you need to make it explicit
var movies: Set<String> = [
    "Matrix",
    "Vingadores",
    "De volta para o futuro",
    "Jurassic Park"
]

var myWifeMovies: Set<String> = [
    "Homem-Aranha",
    "Vingadores"
]

let favoriteMovies: Set = movies.intersection(myWifeMovies)
let allMovies: Set = movies.union(myWifeMovies)


// Enumeradores

enum Compass {
    case north
    case south
    case east
    case weast
    
    // or
    // case north, south, east, weast
}

var heading: Compass = .north

switch heading {
case .north:
    break
default:
    break
}

enum WeekDay: String {
    case sunday = "domingo"
    case monday = "segunda-feira"
    case tuesday = "terça-feira"
    case wednesday = "quarta-feira"
    case thursday = "quinta-feira"
    case friday = "sexta-feira"
    case saturday = "sábado"
}

WeekDay.sunday.hashValue


// Valores associados
enum Measure {
    case size(width: Double, height: Double)
    case age(Int)
    case weight(Double)
}

let measure: Measure = .size(width: 25.0, height: 35.7)

switch measure {
case .age(let age):
    print("A medida é \(age) anos.")
case .size(let size):
    print("A medida é \(size.width) cm de largura e \(size.height) cm de altura.")
case .weight(let weight):
    print("A medida é \(weight) kgs.")
}

// Copy-On-Write
// Mecânismo da linguagem que só faz a cópia da struct apenas no momento que vc altera um valor da struct
// Se vc apenas consumir um objeto struct passado, não haverá a cópia do objeto
// Estruturas
struct Driver {
    var name: String
    var registration: String
    var age: Int
    
    // mutating is because copy-on-write mechanism
    mutating func changeAge(new age: Int) {
        self.age
    }
}


// Functions
// Existe o parametro nomeado externamente e internamente para códigos mais legivel
func say(sentece: String, person: String) {
    print(sentece, person)
}
say(sentece: "Olá", person: "Valmir")

// Better wrote:
func say(_ sentence: String, to person: String) {
    print(sentence, person)
}
say("Olá", to: "Valmir")

var number1 = 12
var number2 = 25

func changeValue(_ value1: inout Int, with value2: inout Int) {
    let oldValue1 = value1
    value1 = value2
    value2 = oldValue1
}

changeValue(&number1, with: &number2)

var teams: [Int: String] = [ 0: "Corinthians", 1: "São Paulo", 2: "Clube do Remo" ]
var teamsArray: [String] = ["Corinthians", "São Paulo", "Clube do Remo"]
for (position, index) in teamsArray.enumerated() {
    print(index, position)
}

func multiply(a: Int, b: Int) -> Int {
    return a * b
}

func sum(a: Int, b: Int) -> Int {
    return a + b
}

func divide(a: Int, b: Int) -> Int {
    return a / b
}

func subtract(a: Int, b: Int) -> Int {
    return a - b
}

// typealias
typealias Operation = (Int, Int) -> Int

//func calculate(a: Int, b: Int, opertion: (Int, Int) -> Int) {
//
//}

func calculate(a: Int, b: Int, operation: Operation) -> Int{
    return operation(a, b)
}

calculate(a: 1, b: 10, operation: sum(a:b:))

//Closures
calculate(a: 10, b: 20, operation: { (c: Int, d: Int) -> Int in
    return c % d
})

//simplifing closure
//1
calculate(a: 10, b: 20, operation: { (c, d) -> Int in
    return c % d
})

//2
calculate(a: 10, b: 20, operation: { (c, d) in
    return c % d
})

//3
calculate(a: 10, b: 20, operation: {
    return $0 % $1
})

//4
calculate(a: 10, b: 20, operation:  { return $0 % $1 })

//5
calculate(a: 10, b: 20) { return $0 % $1 }

//6
calculate(a: 10, b: 20, operation: %)


// High Orders Functions
teamsArray.sort { $0 > $1 }
teamsArray.sort(by: >)

struct Student {
    var name: String
    var age: Int
}
var students: [Student] = [
    Student(name: "Renan", age: 21),
    Student(name: "Ricardo", age: 22),
    Student(name: "Bruno", age: 16)
]

students.sort(by: { $0.name < $1.name })
let oStudents = students.filter({ $0.name.lowercased().hasSuffix("o") })

let uppercaseStudents = students.map({ $0.name.uppercased() })
let ages = students.reduce(0, { $0 + $1.age })
ages


//ARC = Automatic Reference Count
// Weak and unowned self

class Person {
    var name: String
    weak var friend: Person?
    
    init(name: String, friend: Person?) {
        self.name = name
        self.friend = friend
    }
    
    deinit {
        print(name, "desalocado")
    }
}

var haddad: Person? = Person(name: "Haddad", friend: nil)
var bolsonaro: Person? = Person(name: "Bolsonaro", friend: nil)


haddad?.friend = bolsonaro
bolsonaro?.friend = haddad
// retain cycle
// friend attribute should be weak or be care when set nil to one, first we need to set nil on friends

bolsonaro = nil
haddad = nil


class VC: UIViewController {
    var value: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // if not weak, it will generate a retain cycle, and this class will never be deinit
        calculate(a: 12, b: 3) { [weak self] (c, d) -> Int in
            self?.value = c % d
            return c % d
        }
        
    }
}


// weak vs unowned
// weak works with optional
// unowned works with unwraped optional

//calculate(a: 12, b: 3) { [weak self] (c, d) -> Int in
//    guard let self = self else { return 0 }
//    self.value = c % d
//    return c % d
//}

//calculate(a: 12, b: 3) { [unowned self] (c, d) -> Int in
//    guard let self = self else { return 0 }
//    self.value = c % d
//    return c % d
//}

// Errors

enum AccessError: Error {
    case wrongPassword, wrongUser, wrongData
}

func login(userName: String, password: String) throws -> String {
    let validUser = "movile"
    let validPassword = "movile2018"
    
    guard userName == validUser else {
        throw AccessError.wrongUser
    }
    
    guard password == validPassword else {
        throw AccessError.wrongPassword
    }
    
    return "Usuário logado com sucesso"
}

do {
    try login(userName: "valmir", password: "movile2018")
} catch let error {
    let error = error as! AccessError
    
    switch error {
    case .wrongUser:
        print("Dados inválidos")
    case .wrongPassword:
        print("Senha inválida")
    default:
        print("Error")
    }
    
    // or
} // catch is AccessError {
//
//} catch let error as AccessError {
//
//} catch AccessError.wrongUser {
//
//}

//try!
//try?



// Generics

func swapInts(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}

func swap<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

// Generic with constraint
// T: Hashable

class GameTableViewController {
}

// String describing
//let name = String(describing: GameTableViewController.self)
//UIStoryboard(name: "", bundle: nil).instantiateViewController(withIdentifier: name) as? GameTableViewController


// Class
class Vehicle {
    var speed: UInt
    var model: String
    
    // Designated Initializer
    init(speed: UInt, model: String) {
        self.speed = speed
        self.model = model
    }
    
    // Convenience Initializer
    convenience init(model: String) {
        self.init(speed: 0, model: model)
    }
    
    // subscript é a capacidade de acessar dados como em um array

}

extension String {
    subscript(index: Int) -> String? {
        let array = Array(self)
        if index > (array.count - 1) {
            return nil
        }
        return String(Array(self)[index])
    }
}

"Valmir"[3]

// Propriedade computada e propriedade armazenada
extension Optional where Wrapped == Int {
    var valid: Int {
        return self ?? 0
    }
}

Int("a").valid
