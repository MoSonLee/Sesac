import UIKit

/*
 Meta type: 클래스, 구조체, 열거형 유형 그 가리킴
 String 타입은 String.Type
 */

struct User {
    let name = "고래밥" //인스턴스 프로퍼티
    static let oiginalName = "jack" // 타입 프로퍼티
}

let user = User()
user.name
user.self.name

User.oiginalName
User.self.oiginalName

type(of: user.name)

let intValue: Int = 9

func validateUSerInput(text: String) -> Bool {
    guard !(text.isEmpty) else {
        print("빈값")
        return false
    }
    
    guard Int(text) != nil else {
        print("숫자가 아닙니다")
        return false
    }
    
    return true
}

//if validateUSerInputError(text: "2020201") {
//    print("간ㄴ.ㅇ")
//} else {
//    print("불가")
//}

enum ValidationError: Error {
    case emptyString
    case isNotInt
    case isNotDate
}

func validateUSerInputError(text: String) throws -> Bool {
    guard !(text.isEmpty) else {
        throw ValidationError.emptyString
    }
    
    guard Int(text) != nil else {
        throw ValidationError.isNotInt
    }
    
    return true
}

do {
    let result = try validateUSerInput(text: "202222")
    
} catch ValidationError.emptyString {
    print("Empty")
} catch ValidationError.isNotInt {
    print("isNoTINT")
} catch {
    print("ERROr")
}

try validateUSerInput(text: "Aa")
