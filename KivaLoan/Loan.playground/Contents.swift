import UIKit

let json = """
{
"name": "John Davis",
"country": "Peru",
"use": "to buy a new collection of clothes to stock her shop before the holidays."
,
"amount": 150
}
"""

struct Loan: Codable {
    var name: String
    var country: String
    var use: String
    var amount: Int
}

let decoder = JSONDecoder()
if let jsonData = json.data(using: .utf8) {
    do {
        let loan = try decoder.decode(Loan.self, from: jsonData)
        print(loan)
    } catch {
        print(error)
    }
}

let json1 = """
{
"name": "John Davis",
"country": "Peru",
"use": "to buy a new collection of clothes to stock her shop before the holidays."
,
"loan_amount": 150
}
"""

struct Loan1: Codable {
    var name: String
    var country: String
    var use: String
    var amount: Int
    enum CodingKeys: String, CodingKey {
        case name
        case country
        case use
        case amount = "loan_amount"
    }
}

let decoder1 = JSONDecoder()
if let jsonData = json1.data(using: .utf8) {
    do {
        let loan = try decoder1.decode(Loan1.self, from: jsonData)
        print(loan)
    } catch {
        print(error)
    }
}

let json2 = """
{
"name": "John Davis",
"location": {
"country": "Peru",
},
"use": "to buy a new collection of clothes to stock her shop before the holidays."
,
"loan_amount": 150
}
"""

struct Loan2: Codable {
    var name: String
    var country: String
    var use: String
    var amount: Int
    enum CodingKeys: String, CodingKey {
        case name
        case country = "location"
        case use
        case amount = "loan_amount"
    }
    enum LocationKeys: String, CodingKey {
        case country
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        let location = try values.nestedContainer(keyedBy: LocationKeys.self, forKey: .country)
        country = try location.decode(String.self, forKey: .country)
        use = try values.decode(String.self, forKey: .use)
        amount = try values.decode(Int.self, forKey: .amount)
    }
}

let decoder2 = JSONDecoder()
if let jsonData = json2.data(using: .utf8) {
    do {
        let loan = try decoder2.decode(Loan2.self, from: jsonData)
        print(loan)
    } catch {
        print(error)
    }
}

let json3 = """
[{
"name": "John Davis",
"location": {
"country": "Paraguay",
},
"use": "to buy a new collection of clothes to stock her shop before the holidays."
,
"loan_amount": 150
},
{
"name": "Las Margaritas Group",
"location": {
"country": "Colombia",
},
"use": "to purchase coal in large quantities for resale.",
"loan_amount": 200
}]
"""


