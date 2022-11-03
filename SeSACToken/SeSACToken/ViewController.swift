//
//  ViewController.swift
//  SeSACToken
//
//  Created by 이승후 on 2022/11/02.
//

import UIKit

import RxSwift

final class ViewController: UIViewController {
    
    @IBOutlet private weak var mailLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    private let viewModel = ProfileViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let phone = Phone()
        print(phone.numbers[2])
        
        viewModel.profile
            .withUnretained(self)
            .subscribe { (vc, value) in
                vc.nameLabel.text = value.user.username
                vc.mailLabel.text = value.user.email
                print(value.user.email)
                print(value.user.username)
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        viewModel.getProfile()
        checkCOW()
    }
    
    func checkCOW() {
        var test = "jack"
        address(&test) //inout 매개변수
        
        print(test[1])
        
        var array = Array(repeating: "A", count: 100)
        address(&array)
        
        print(array[safe: 99])
        print(array[safe: 199])
        
        var newArray = array
        address(&newArray)
        
        newArray[0] = "B"
        
        address(&array)
        address(&newArray)
    }
    
    func address(_ value: UnsafeRawPointer) {
        let address = String(format: "%p", Int(bitPattern: value))
        print(address)
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

struct Phone {
    var numbers = ["1234", "45"]
    
    subscript(idx: Int) -> String {
        get {
            return self.numbers[idx]
        }
        set {
            self.numbers[idx] = newValue
        }
    }
}
