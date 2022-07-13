//import UIKit
//
//func setNickname() -> Void {
//    print("저는 고래밥입니다.")
//}
//
//setNickname()
//
//func setNicknameParameter(nickname: String) {
//    print("저는 \(nickname)입니다")
//}
//
//setNicknameParameter(nickname: "칙촉")
//
//
//
//enum Sesac: Int {
//    case firstMember
//    case secondMember
//    case thirdMember
//}
//print(Sesac.firstMember.rawValue)
//print(Sesac.secondMember.rawValue)
//print(Sesac.thirdMember.rawValue)
//
//func returnEX() -> String {
//    print("A")
//    return "나는 2기멤버"
//}
//let ex = returnEX()
//returnEX()
//print(ex)
//
//
//var peopleFrom: Sesac = .firstMember
//
//if peopleFrom == .firstMember {
//    print("1기 멤버")
//} else if peopleFrom == .secondMember {
//    print("2기 멤버")
//} else if peopleFrom == .thirdMember {
//    print("3기 멤버")
//} else {
//    print("불합격자")
//}
//
//var tuple = ("1", true, 50)
//print(tuple)
//
//var tuple2 = (tuple, true)
//print(tuple2)
//
//func ex1() -> Int {
//    return 1
//}
//
//func ex2() -> String {
//    return "2"
//}
//
//func ex3() -> Bool {
//    return true
//}
//
//var tuple3 = (ex1(), ex2(), ex3())
//print(tuple3)
//
//var rawStringEx1 = #"\MosonLEE"#
//
//print(rawStringEx1)
//
//
//class SuperClass {
//    func ex1() {
//        print("I am superClass")
//    }
//}
//
//class ChildClass: SuperClass {
//    override func ex1() {
//        print("I am childClass")
//    }
//}
//
//SuperClass().ex1()
//ChildClass().ex1()
//
//
//var ex1 = ["1", "2", "3"]
//ex1.shuffle()
//print(ex1)
//
//var ex2 = ["1", "2", "3", "4"]
//let shuffledArray = ex2.shuffled()
//print(shuffledArray)
//

//
//import Foundation
//
//var email: String = "MosonLe"
//var email2: String?
//email2 = "Moson"
//
//type(of: email)
//type(of: email2)
//
//var array = [1, 2, 3, 4, 5, 6 ,7, 8, 9]
//var array1 = Array(repeating: 0, count: 100)
//
//var array2: [Int]? = [Int](1...100)
//type(of: array2)
//
//if array2?.count == 0 {
//    print("값이 없습니다")
//} else {
//    print("값이 있습니다.")
//}
//
////삼항연산자
//let result = array2 == nil ? "값이 없습니다" : "값이 있습니다."
//
//func example() -> String {
//
//    let result = Int.random(in: 1...100)
//    return result > 50 ? "UP" : "Down"
//}
//print(example())
//
//@discardableResult // 리턴 값을 사용하지 않을떄 + 내부코드는 다 작동함
//func bmiResult() -> (String,Double) {
//    let result = Double.random(in: 1...30)
//    if result > 18.5 {
//        return ("고래밥", 1.0)
//    } else if result >= 18.5 && result < 23  {
//        return ("고오래밥", 2.0)
//    }
//    return ("코오오오래애애바밥", 3.0)
//}
//
//print(bmiResult())
//
//let userBMI = bmiResult()
////문자열 보간법: String Interpolation
//print("\(userBMI.0)님의 BMI 등급은 \(userBMI.1)입니다.")
//print(userBMI.0 + "님의 BMI 등급은" + "\(userBMI.1)" + "입니다.")
//
//
//// 닉네임: 손님
//func sayHello(nickName: String? = "손님") -> String {
//    return nickName! + "님, 반갑습니다!"
//}
//let user = array2 == nil ? "손님" : "고래밥"
//print(sayHello(nickName: user))
//
//
//enum Gender: String {
//    case man
//    case woman
//    case nothind
//}
//var gender: Gender = Gender.man
//
//switch gender {
//case .man: print("남성입니다.")
//case .woman: print("여성입니다")
//default:
//    print("오류입니다.")
//}
//
//print(gender.rawValue)
//
//enum HTTPCode: Int {
//    case OK
//    case No_PAGE
//    case NOT_FOUND = 404
//    case SERVER_ERROR
//
//    func showStatus() -> String {
//        switch self {
//        case .OK: return "정상"
//        case .SERVER_ERROR: return "긴급점검"
//        case .NOT_FOUND: return "잘못된 문제"
//        case.No_PAGE: return "페이지를 찾을 수 없음"
//        }
//    }
//}
//var networkStatus: HTTPCode = .SERVER_ERROR
//
////switch networkStatus {
////case .OK: print("정상", networkStatus.rawValue)
////case .No_PAGE: print("잘못된 URL 주소", networkStatus.rawValue)
////default: print("기타", networkStatus.rawValue)
////}
//
//let resultStatus = networkStatus.showStatus()
//print(resultStatus)
//

//import Foundation
//
class Monster {
    var clothes = "Orange"
    var speed = 5
    var power = 20
    var expoint: Double = 500

    func attack() {
        print("공격!!!")
    }
    struct MM {
        
    }
}

struct MonsterStruct {
    var clothes = "Orange"
    var speed = 5
    var power = 20
    var expoint: Double = 500

    func attack() {
        print("공격!!!")
    }
    class M {
        
    }
}
print(MonsterStruct.self)
//
//var nickname = "고래밥" // 초기화
//var easyMoster = Monster() // 초기화(인스턴스)
//easyMoster.clothes
//easyMoster.power
//easyMoster.attack()
//easyMoster.attack()
//
//class BossMonster: Monster {
//    var levelLimit = 500
//    func bossAttack() {
//        print("보스 어택!")
//    }
//    override func attack() {
//        super.attack()
//        print("override 공격!!")
//    }
//}
//
//var finalBoss = BossMonster()
//finalBoss.bossAttack()
//finalBoss.levelLimit
//finalBoss.clothes
//finalBoss.speed
//finalBoss.attack()
//
//import Foundation
//
//var nickname1 = "MosonLee"
//var subNickname1 = nickname
//subNickname1 = "Seung"
//
//print(nickname)
//print(subNickname1)
//
//var minMonster = Monster()
//var bossMoster = minMonster
//bossMoster.power = 5000
//print(minMonster.power)
//print(bossMoster.power)
//
//// 구조체는 값 타입, 클래스는 참조 타입
