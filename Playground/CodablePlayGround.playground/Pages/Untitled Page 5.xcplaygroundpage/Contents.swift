//: [Previous](@previous)

import Foundation

struct User: Encodable {
    let name: String
    let age: Int
    let signDate: Date
}

let users: [User] = [
    User(name: "Jack", age: 33, signDate: Date()),
    User(name: "Elsa", age: 18, signDate: Date(timeInterval: -86400, since: Date())),
    User(name: "Emily", age: 11, signDate: Date(timeIntervalSinceNow: 86400*2))
]

dump(users)

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted // 이쁘게 프린트하기...^^
encoder.dateEncodingStrategy = .iso8601 // Date 출력 형식

let format = DateFormatter()
format.locale = Locale(identifier: "ko-kr")
format.dateFormat = "MM월 dd일 EEEE"

encoder.dateEncodingStrategy = .formatted(format)

do {
    let result = try encoder.encode(users) // User -> Data
    print(result)
    
    guard let jsonString = String(data: result, encoding: .utf8) else { // Data -> String
        fatalError("Error")
    }
    print(jsonString)
    
} catch {
    print(error)
}

//: [Next](@next)
