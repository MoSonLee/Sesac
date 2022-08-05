import UIKit
import Darwin

//일급 객체, 클로저
//일급 객체: 변수나 상수에 함수를 넣을 수 있다, 반환타입에 함수를 넣을 수 있다, 인자 값으로 함수를 넣을 수 있다.

/*
 1급 객체:
 1. 변수나 상수에 함수를 대입할 수 있다.

 */

func checkBankInformation(bank: String) -> Bool {
    let bankArray = ["우리", "국민", "신한"]
    return bankArray.contains(bank) ? true : false
}

//변수나 상수에 함수를 실행해서 반환된 반환값을 대입한 것 (1급 객체의 특성은 아님)
let checkResult = checkBankInformation(bank: "우리")
print(checkResult)

//변수나 상수에 함수 자체를 대입할 수 있다(1급 객체의 특성)
//단지 함수만 대입한 것으로, 실행된 상태는 아님.
let checkAccount = checkBankInformation

//(Stirng) -> Bool 이게 뭘까? -> Function Type (ex. Tuple)

//함수를 호출해줘야 실행이 된다.
checkAccount("신한")

//Function Type: (String) -> String
func hello(userName: String) -> String {
    return "저는 \(userName)입니다."
}

//Function Type: (String, Int) -> String
func hello(userName: String, age: Int) -> String {
    return "저는 \(userName), \(age)살입니다."
}

//오버로딩 특성으로 함수를 구분하기 힘들 때, 타입 어노테이션을 통해서 함수를 구별할 수 이싿.
//하지만 타입 어노테이션만으로 함수를 구별할 수 없는 상황도 있다./
//함수 표기법을 사용한다면 타입 어노테이션을 생랼가허다로 함수를 구별할 수 있다.

let result: (String) -> String = hello(userName: ) // 함수 표기법
result("고래밥")

let ageResult: (String, Int) -> String = hello
ageResult("고래밥", 30)

func hello(nickname: String) -> String {
    return "저는 \(nickname)입니다."
}
let result2 = hello(nickname: ) // 함수 표기법
result2("상어밥")

//2번 특성
func oddNumber() {
    print("홀수")
}

func evenNumber() {
    print("짝수")
}

func resultNumber(number: Int, odd: () -> (), even: () -> () ) {
    return number.isMultiple(of: 2) ? even() : odd()
}
resultNumber(number: 0, odd: oddNumber, even: evenNumber)
//resultNumber(number: 9, odd: oddNumber, even: evenNumber)
//resultNumber(number: <#T##Int#>) {
//    <#code#>
//} even: {
//    <#code#>
//}


//2. 함수의 반환 타입으로 함수를 사용할 수 있다.

func currentAccount() -> String {
    return "계좌 있음"
}

func noCurrentAccount() -> String {
    return "계좌 없음"
}

func checkBank(bank: String) -> () -> String {
    let bankArray = ["우리", "신한", "국민"]
    return bankArray.contains(bank) ? currentAccount : noCurrentAccount
}

let seung = checkBank(bank: "농협")
seung()

func plus(a: Int, b: Int) -> Int {
    return a + b
}

func minus(a: Int, b: Int) -> Int {
    return a - b
}

func multiply(a: Int, b: Int) -> Int {
    return a * b
}

func divide(a: Int, b: Int) -> Int {
    return a / b
}

func calculate(operand: String) -> (Int, Int) -> Int {
    
    switch operand {
    case "+": return plus
    case "-": return minus
    case "*": return multiply
    case "/": return divide
    default: return plus
    }
}

let resultCalculate = calculate(operand: "+") //함수가 실행되고 있는 상태가 아님
resultCalculate(3,5)

/*
 클로저: 이름 없는 함수
 */

//() -> ()
func studyiOS() {
    print("주말에도 공부하기")
}

let studyiOSHarder: () -> () = {
    print("주말에도 공부하기")
}
// 클로저 헤더 in 클로저 바디
let studyiOSHarder2 = { () -> () in
    print("주말에도 공부하기")
}()

studyiOSHarder2

// 코드를 생략하지 않고 클로저 구문 씀. 함수의 매개변수 내에 클로저가 그대로 들어간 형태
// => 인라인 클로저
func getStudyWithMe(study: () -> () ) {
    print("GetStudyWithMe")
    study()
}

//함수 뒤에 클로저가 실행
// -> 트레일링(후행) 클로저
getStudyWithMe() { () -> () in
    print("주말에도 공부하기")
}

//func randomNumber(number: (Int) -> String) {
//    return "\(number)"
//}

func randomNumber(result: (Int) -> String) {
    result(Int.random(in: 1...100))
}

//randomNumber(result: { (Int) -> String in
//        return "행운의 숫자는 \(number)입니다."
//})
randomNumber(result: {
    "행운의 숫자는 \($0)입니다."
})

randomNumber {
    "\($0)"
}

let student = [2.2,  4.5, 4.0, 1.2, 1.5, 3.4, 4.4, 1.2, 3.5, 3.9, 2.2,  4.5, 4.0, 1.2, 1.5, 3.4, 4.4, 1.2, 3.5, 3.0, 2.2,  4.5, 4.0, 1.2, 1.5, 3.4, 4.4, 1.2, 3.5]
var newStudet: [Double] = []


func processTime(code: () -> ()) {
    let start = CFAbsoluteTimeGetCurrent()
    code()
    let end = CFAbsoluteTimeGetCurrent() - start
    print(end)
}

processTime {
    for student in student {
        if student >= 4.0 {
            newStudet.append(student)
        }
    }
}

for student in student {
    if student >= 4.0 {
        newStudet.append(student)
    }
}
print(student)

let filterStudent = student.filter { value in
    value >= 4.0
}

processTime {
    let  filterStudent2 = student.filter { $0 >= 4.0 }
}

//let  filterStudent2 = student.filter { $0 >= 4.0 }
print(filterStudent)

//Map: 기존 요소를 클로저를 통해 원하는 결과 값을 ㅗ변경
let number = [Int](1...1000)
var newNumber: [Int] = []
for number in number {
    newNumber.append(number * 3)
}
print(newNumber)

let mapNumber = number.map { $0 *  3 }
print(mapNumber)
let movieList = [
    "a" : "AA",
    "b" : "BB",
    "c" : "CC"
]

let movieResult = movieList.filter { $0.value  == "AA"}
print(movieResult)

let movieResult2 = movieList.filter { $0.value  == "AA"}.map { $0.key }
print(movieResult2)

//reduce
let examScore: [Double] = [100, 20,  40, 77, 74, 91 ,95]

let totalCoutntUsingReducer = examScore.reduce(0) { return $0 + $1 }
print(totalCoutntUsingReducer / 8)

func drawingGame(item: Int) -> String {
    func luckyNumber(number: Int) -> String {
        return "\(number * Int.random(in: 1...10))"
    }
    let result = luckyNumber(number: item)
    return result
}
drawingGame(item: 10)

//내부 함수를 반환하는 외부 함수로 만들 수 있다.
func drawingGame2(item: Int) -> () -> String {
    func luckyNumber() -> String {
        return "\(item * Int.random(in: 1...10))"
    }
    return luckyNumber
}

let numberResult = drawingGame2(item: 10) // 내부 함수는 아직 동작하지 않음
numberResult() //외부 함수의 생명주기가 끝났는데 내부 함수는 사용이 가능한 상황이 됨

//은닉성()이 있는 내부 함수를 외부함수의 실행 결과로 반환하면서 내부 함수를 외부에서도 접근 가능하게 되었음
//이제 얼마든지 호출이 가능. 이건 생명주기에도 영향을 미침. 외부 함수가 종료되더라도 내부 함수는 살아있음

//클로저
//같은 정의를 갖는 함수가 서로 다른 환경을 저장하는 결과가 생기게 됨
//클로저의 의해 내부 함수 주변의 지역변수나 상수도 함께 저장됨. -> 값이 캡쳐되었다고 표현함 -> 캡쳐리스트 -> weak, strongm unowned(강한, 약한 순환 참조 등)
// 주변 환경에 포함된 변수나 상수의 타입이 기본 자료형이나 구조체 자료형일 때 발생함. 클로저 캡쳐 기본 기능임
