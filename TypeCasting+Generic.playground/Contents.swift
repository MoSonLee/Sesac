import UIKit

/*
 TypeCasting
 - 형 변환 => 타입캐스팅/타입변환
 - 타입캐스팅: 인스턴스의 타입을 확인하거나 인스턴스 자신의 타입을 다른 타입의 인스턴스인 것 처럼 사용할 때 활용되는 개념
 */

let a = 3
let value = String(a) //이니셜라이저 구문을 통해 새롭게 인스턴스를 생성한 것 = 형변환

type(of: a)
type(of: value)

// 애플 구글 모바일

class Mobile {
    let name: String
    
    var introduce: String {
        return "\(name)입니다"
    }
    
    init(name: String) {
        self.name = name
    }
}

class Google: Mobile {
    
}

class Apple: Mobile {
    let wwdc = "WWDC22"
}

let mobile = Mobile(name: "PHONE")
let apple = Apple(name: "APPLE")
let google = Google(name: "GOOGLE")

// is: 어떤 클래스의 인스턴스 타입, 데이터 타입인지 확인
// ex: Local Notification

mobile is Mobile
mobile is Google
mobile is Apple

apple is Mobile

//Type Cast Operaot: as(업캐스팅) / as? (다운캐스팅) / as! (다운캐스팅)
//업캐스팅" 부모클래스 타입인걸 알 경우, 항상 성공하는 걸 알 경우

let iphone = Apple(name: "APPLE")

//as? 옵셔널 반환 타입 -> 실패할 경우 nil 반환
//as! 옵셔널 X -> 실패할 경우 무조건 런타입 에러 발생
if let value = iphone as? Apple {
    print(value.wwdc)
} else {
    print("타입 캐스팅 ㅅ길패")
}

apple as Mobile

// Any vs AnyObject

var something: [Any] = []
something.append(0)
something.append(true)
something.append("something")
something.append(mobile.introduce)

print(something)
let example = something[1]

if let element = example as? Bool {
    print(element)
} else {
    print("Bool type이 아닙니다.")
}

/*
 Generic
 - 타입에 유연하게 대응
 - type PArameter: placeholder 역할. 어떤 타입인지 타입의 종류는 알려주지 않음.
 특정한 타입 하나라는건 알 수 있음. 제네릭으로 이루어진 함수 사용 시 T에 들어갈 타입은 모두 같아야 한다. UpperCased로 작성. ex T U K
 - Type Constraints: 클래스/ 프로토콜 제약
 */

func configureBorderLabel(_ view: UILabel) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

func configureBorderButton(_ view: UIButton) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

func configureBorderTextField(_ view: UITextField) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

func configureBorder<SEUNG: UIView>(_ view: SEUNG) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

let imageView = UIImageView()
let lbl = UILabel()

configureBorder(lbl)
configureBorder(imageView)

struct DummyData<T, U> {
    var mainContents: T
    var subContents: U
}

let cast = DummyData(mainContents: "현빈", subContents: 1)
let phoneNumber = DummyData(mainContents: "고래밥", subContents: 2)

func total(a: [Int]) -> Int {
    return a.reduce(0, +)
}

func total(a: [Double]) -> Double {
    return a.reduce(0, +)
}

func total(a: [Float]) -> Float {
    return a.reduce(0, +)
}

total(a: [1,2,3,4,5,6,7,8,9])

func total<T: Numeric>(a: [T]) -> T {
    return a.reduce(.zero, +) as! T
}

//화면 전환 코드

class SampleViewController: UIViewController{
    
    func transitionViewController<T: UIViewController>(sb: String, vc: T) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: String(describing: vc)) as! T
        
        self.present(vc, animated: true)
    }
}

class Animal: Equatable {
    
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

let one = Animal(name: "고양이")
let two = Animal(name: "고양이")

one.name == two.name

one == two

var fruit1 = "사과"
var fruit2 = "바나나"

swap(&fruit1, &fruit2)

func swapTwoInts(a: inout Int, b: inout Int) {
    let tempA = a
    a = b
    b = tempA
}
