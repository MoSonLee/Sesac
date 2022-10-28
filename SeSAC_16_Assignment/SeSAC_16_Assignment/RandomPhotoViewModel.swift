//
//  RandomPhotoViewModel.swift
//  SeSAC_16_Assignment
//
//  Created by 이승후 on 2022/10/24.
//

import Foundation

import RxCocoa
import RxSwift

final class RandomPhotoViewModel {
    
    var randomPhotoList = PublishSubject<RandomPhoto>()
    //    var randomPhotoList: CObservable<RandomPhoto> = CObservable(RandomPhoto(urls: Urls(raw: "", full: "", regular: "", small: "", thumb: "", smallS3: ""), likes: 0))
    
    func requestRandomPhoto() {
        APIService.randomPhoto(completion: { randomPhoto, statusCode, error in
            guard let randomPhoto = randomPhoto else { return }
            self.randomPhotoList.onNext(randomPhoto)
            //            self.randomPhotoList.value = randomPhoto
        })
    }
}
