//: [Previous](@previous)

import Foundation

class User {
    var nickname = "MOSONLEE"
    
    lazy var introduce = { [weak self] in
        return "저는 \(self?.nickname ?? "손님")입니다!"
    }
    
    init() {
        print("User Init")
    }
    
    deinit{
        print("User Deinit")
    }
}

var user: User? = User()

user?.introduce

user = nil

func myClosure() {
    
    var number = 0
    print("1: \(number)")
    
    let closure: () -> Void = {
        print("closure: \(number)")
    }
    
    closure()
    
    number = 100
    print("2: \(number)")
    
    closure()
}

myClosure()

//: [Next](@next)
