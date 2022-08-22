//
//  RealmModel.swift
//  DiaryUnsplashApp
//
//  Created by 이승후 on 2022/08/22.
//

import Foundation
import RealmSwift

//userDiary: 테이블 이름
//@Persisted: 컬럼
class userDiary: Object {
    @Persisted var diaryTitle: String //제목 필수
    @Persisted var diaryContent: String? // 내용 옵션
    @Persisted var diaryDate = Date() // 작성 날짜 필수
    @Persisted var diaryRegisterDate = Date() // 등록 날짜 필수
    @Persisted var like: Bool //즐겨찾기 필수
    @Persisted var diaryPhoto: String? // 사진 string 옵션
    
    //PK(필수): Int, UUID, ObjectID
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(diaryTitle: String, diaryContent: String?, diaryDate: Date, diaryRegisterDate: Date
                     ,photo: String?) {
        self.init()
        self.diaryTitle = diaryTitle
        self.diaryContent = diaryContent
        self.diaryDate = diaryDate
        self.diaryRegisterDate = diaryRegisterDate
        self.like = false
        self.diaryPhoto = diaryPhoto
    }
}
