import UIKit

//1. Optional binding

//ex. 쇼핑 리스트 추가
var shoplist: String? = "신발 구매하기"
var shoplist2: String? = "모니터 사기"

if shoplist != nil && shoplist2 != nil {
    print("\(shoplist!), \(shoplist2!) 완료!")
} else {
    print("값을 입력해주세요")
}

// 두글자 이상을 꼭 입력해야 한다면?
shoplist = nil
if let value = shoplist, let value = shoplist2, (2...6).contains(value.count) {
    print("\(value) 완료!")
} else {
    print("글자를 입력해주세요")
}

func optionBindingFunction() {
    guard let seung = shoplist, let value = shoplist2, (2...6).contains(seung.count) else  {
        print("글자를 입력해주세요")
        return
    }
    print("\(seung) 완료!")
}
//2. instance property, type property
class User {
    var nickname = "고래밥" //저장 프로퍼티, 인스턴스 프로퍼티(인스턴스를 통해 접근 가능)
    static var staticNickname = "고래밥" // 저장 프로퍼티(상수 저장 프로퍼티/ 변수 저장 프로퍼티), 타입 프로퍼티
}

let user = User() // 클래스 초기화, 인스턴스 생성
print(user.nickname) //
//UI가 앞에 붙어 있는 것들은 -> 모두 클래스

let user2 = User()
let user3 = User()
let user4 = User()

// -> 메모리에 올라감. 인스턴스를 생성한다고 해서 초기화가 되지 않음 -> 사용할 떄 초기화가 이뤄짐, 앱을 실행하는 내내 올라가 있음
//선언할 떄 초기값을 넣어줘야함
User.staticNickname
print(User.staticNickname)
