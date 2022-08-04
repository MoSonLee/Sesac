import UIKit

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
