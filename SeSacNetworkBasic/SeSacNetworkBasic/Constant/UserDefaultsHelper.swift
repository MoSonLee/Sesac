//
//  UserDefaultsHelper.swift
//  SeSacNetworkBasic
//
//  Created by 이승후 on 2022/08/01.
//

import Foundation

class UserDefaultsHelper {
    
    private init() { }
    
    static let standard = UserDefaultsHelper()
    let userDefaults = UserDefaults.standard // Singleton pattern 자기 자신의 인스턴스 타입을 프로퍼티 형태로 가지고 있음
    
    enum Key: String {
        case nickname, age
    }
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set { //연산 프로퍼티 parameter
            userDefaults.set(newValue, forKey:  Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
}
