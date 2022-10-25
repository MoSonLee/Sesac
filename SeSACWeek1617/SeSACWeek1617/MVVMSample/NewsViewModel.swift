//
//  NewsViewModel.swift
//  SeSACWeek1617
//
//  Created by 이승후 on 2022/10/20.
//

import Foundation

import RxSwift

class NewsViewModel {
    
    //    var pageNumber: CObservable<String> = CObservable("3000")
    //    var sample: CObservable<[News.NewsItem]> = CObservable(News.items)
    
    var pageNumber = BehaviorSubject(value: "3000")
    var sample = PublishSubject<[News.NewsItem]>()
    
    func changePageNumberFormat(text: String) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let text = text.replacingOccurrences(of: ",", with: "")
        guard let number = Int(text) else { return }
        
        let result = numberFormatter.string(for: number)!
        pageNumber.onNext(result)
        //        pageNumber.value = result
    }
    
    func resetSample() {
        sample.onNext([])
    }
    
    func loadSample() {
        sample.onNext(News.items)
        //        sample.value = News.items
    }
    
}
