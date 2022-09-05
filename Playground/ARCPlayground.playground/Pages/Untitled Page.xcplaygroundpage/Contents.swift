import UIKit

class Guild {
    
    var name: String
    weak var owner: User? // 이 길드장은 누구?
    
    init(name: String) {
        self.name = name
        print("Guild Init")
    }
    
    deinit {
        print("Guild deinit")
    }
}

guild = nil //Guild: Rc = 0, 메모리에서 제거됨

class User {
    var name: String
    var guild: Guild? // 고래밥이 새싹 길드에 있다면?
    
    init(name: String) {
        self.name = name
        print("User Init")
    }
    
    deinit {
        print("User Deinit")
    }
}

var user: User? = User(name: "고래밥") // User: RC 1
var guild: Guild? = Guild(name: "SeSAC") // Guild: Rc 1

user?.guild = guild //Guild: Rc 2
guild?.owner = user // USer: Rc 2

//순환참조 중인 요소를 먼저 nil 인스턴스의 참조 관계 해제 -> weak unowned 등장
//user?.guild = nil //Guild: RC 1
//guild?.owner = nil

//guild = nil
user = nil

guild?.owner // 메모리 주소는 남아있음

//guild = nil // Guild RC 0
//user = nil // User Rc1


