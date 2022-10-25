//
//  SubjectViewModel.swift
//  SeSACWeek1617
//
//  Created by 이승후 on 2022/10/25.
//

import Foundation

import RxSwift

struct Contact {
    var name: String
    var age: Int
    var number: String
}

class SubjectViewModel {
    var contactData = [
        Contact(name: "Seunghoo", age: 27, number: "010010010"),
        Contact(name: "LeeSeunghoo", age: 29, number: "0100100101"),
        Contact(name: "MetaVerse Seunghoo", age: 17, number: "0100100101")
    ]
    
    var list = PublishSubject<[Contact]>()
    
    func fetchData() {
        list.onNext(contactData)
    }
    
    func resetData() {
        list.onNext([])
    }
    
    func newData() {
        let new = Contact(name: "고래밥", age: Int.random(in: 10...50), number: "")
        contactData.append(new)
        list.onNext(contactData)
    }
    
    func filterData(query: String) {
        let result = query != "" ? contactData.filter{ $0.name.contains(query)} : contactData
        list.onNext(result)
    }
}
