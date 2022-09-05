//
//  Observable.swift
//  Sesac2Week9
//
//  Created by 이승후 on 2022/08/31.
//

import Foundation

class Observable<T> {

    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("Didset", value)
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}

//class User {
//    
//    Observable<Int>> =
//    
//    private var listener: ((String) -> Void)?
//    
//    
//    var value: String {
//        didSet {
//            print("data changed")
//            listener?(value)
//        }
//    }
//    
//    init(name: String) {
//        value = name
//    }
//}
