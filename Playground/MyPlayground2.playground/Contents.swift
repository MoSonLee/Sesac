import Foundation

//옵셔널로 선언된 프로퍼티는 nil을 가질 수 있음. -> 나중에 초기화해도됨
//nil을 담을 수 없는 프로퍼티는 값이 무조건 있어야한다. -> 초기화가 필요함. -> 이니셜라이저 사용
class Monster {
    var name: String
    var level: Int
    
    init(name: String, level: Int) {
        self.name = name
        self.level = level
    }
}

let easy = Monster(name: "MosonLee", level: 12)

var hard = easy

print(easy.name, easy.level)
print(hard.name, hard.level)


struct StructMonster {
    var name: String
    var level: Int
}

let structMonster = StructMonster(name: "MosonLEEEEEE", level: 1222222)
