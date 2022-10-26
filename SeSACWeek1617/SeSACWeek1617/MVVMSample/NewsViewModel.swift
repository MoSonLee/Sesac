//
//  NewsViewModel.swift
//  SeSACWeek1617
//
//  Created by 이승후 on 2022/10/20.
//

import Foundation

import RxCocoa
import RxSwift

final class NewsViewModel {
    //    var pageNumber: CObservable<String> = CObservable("3000")
    //    var sample: CObservable<[News.NewsItem]> = CObservable(News.items)
    
    var pageNumber = BehaviorSubject<String>(value: "3,000")
//    var sample = BehaviorSubject(value: News.items)
//    var sample = PublishSubject<[News.NewsItem]>()
    var sample = BehaviorRelay(value: News.items)
    
    func changePageNumberFormat(text: String) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let text = text.replacingOccurrences(of: ",", with: "")
        guard let number = Int(text) else { return }
        let result = numberFormatter.string(for: number)!
        pageNumber.onNext(result)
        //값을 넣는 것은 onNext 이벤트와 유사하다고 생각하자.
        //        pageNumber.value = result
    }
    
    func resetSample() {
        sample.accept([])
//        sample.onNext([])
    }
    
    func loadSample() {
        sample.accept(News.items)
//        sample.onNext(News.items)
        //        sample.value = News.items
    }
}
