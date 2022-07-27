import Foundation

//옵셔널로 선언된 프로퍼티는 nil을 가질 수 있음. -> 나중에 초기화해도됨
//nil을 담을 수 없는 프로퍼티는 값이 무조건 있어야한다. -> 초기화가 필요함. -> 이니셜라이저 사용
//class Monster {
//    var name: String
//    var level: Int
//
//    init(name: String, level: Int) {
//        self.name = name
//        self.level = level
//    }
//}
//
//let easy = Monster(name: "MosonLee", level: 12)
//
//var hard = easy
//
//print(easy.name, easy.level)
//print(hard.name, hard.level)
//
//
//struct StructMonster {
//    var name: String
//    var level: Int
//}
//
//let structMonster = StructMonster(name: "MosonLEEEEEE", level: 1222222)
//

//var nickName: String? = "MosonLee"
//
//if let name = nickName {
//    print("닉네임은 \(name)입니다.")
//} else {
//    print("없는 값입니다.")
//}



//func ex() {
//    let nickName: String? = "MosonLee"
//
//    guard let name = nickName else {
//        return print("없는 값입니다.")
//    }
//    print(name)
//}
//ex()

class EX {
    //저장 프로퍼티(상수, 변수), 인스턴스 프로퍼티
    var nickName = "MosonLEE"
    // 저장 프로퍼티(상수, 변수), 타입 프로퍼티
    static var staticName = "MosonLeeStatic"
}
