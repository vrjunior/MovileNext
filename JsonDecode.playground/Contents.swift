import UIKit


// Para prevenir que o backend quebre seu app, é uma garantia deixar todos os parametros optional

struct User: Codable {
    var firstName: String
    var middleName: String
    var lastName: String
    var date: Date
    var billingAddress: BillingAddress
    
    enum CodingKeys: String, CodingKey {
        case firstName // = "first_name"
        case middleName // = "middle_name"
        case lastName // = "last_name"
        case billingAddress
        case date
    }
}


struct BillingAddress: Codable {
    var streetName: String
    var district: String
    var postalCode: String
    var city: String
    var country: String
}


if let url = Bundle.main.url(forResource: "user.json", withExtension: nil) {
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        
        // Prevents coding keys when the var names is on underscore convention
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        let user = try decoder.decode(User.self, from: data)
    } catch {
        print(error)
    }
}

