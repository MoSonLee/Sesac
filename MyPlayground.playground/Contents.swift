////import UIKit
//////
//////func setNickname() -> Void {
//////    print("저는 고래밥입니다.")
//////}
//////
//////setNickname()
//////
//////func setNicknameParameter(nickname: String) {
//////    print("저는 \(nickname)입니다")
//////}
//////
//////setNicknameParameter(nickname: "칙촉")
//////
////
//////
//////enum Sesac: Int {
//////    case firstMember
//////    case secondMember
//////    case thirdMember
//////}
//////print(Sesac.firstMember.rawValue)
//////print(Sesac.secondMember.rawValue)
//////print(Sesac.thirdMember.rawValue)
////
//////func returnEX() -> String {
//////    print("A")
//////    return "나는 2기멤버"
//////}
//////let ex = returnEX()
//////returnEX()
//////print(ex)
////
////
//////var peopleFrom: Sesac = .firstMember
//////
//////if peopleFrom == .firstMember {
//////    print("1기 멤버")
//////} else if peopleFrom == .secondMember {
//////    print("2기 멤버")
//////} else if peopleFrom == .thirdMember {
//////    print("3기 멤버")
//////} else {
//////    print("불합격자")
//////}
////
//////var tuple = ("1", true, 50)
//////print(tuple)
//////
//////var tuple2 = (tuple, true)
//////print(tuple2)
////
////func ex1() -> Int {
////    return 1
////}
////
////func ex2() -> String {
////    return "2"
////}
////
////func ex3() -> Bool {
////    return true
////}
////
////var tuple3 = (ex1(), ex2(), ex3())
////print(tuple3)
////
////var rawStringEx1 = #"\MosonLEE"#
////
////print(rawStringEx1)
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

var ex1 = ["1", "2", "3"]
ex1.shuffle()
print(ex1)

var ex2 = ["1", "2", "3", "4"]
let shuffledArray = ex2.shuffled()
print(shuffledArray)

