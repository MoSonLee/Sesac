//
//  UserDiary.swift
//  CalendarApp
//
//  Created by 이승후 on 2022/08/27.
//

import Foundation
import RealmSwift

//userDiary: 테이블 이름
//@Persisted: 컬럼
class UserDiary: Object {
    @Persisted var diaryTitle: String //제목 필수
    @Persisted var diaryContent: String? // 내용 옵션
//    @Persisted var diaryPhoto: String? // 사진 string 옵션
    
    //PK(필수): Int, UUID, ObjectID
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(diaryTitle: String, diaryContent: String?) {
        self.init()
        self.diaryTitle = diaryTitle
        self.diaryContent = diaryContent
//        self.diaryPhoto = diaryPhoto
    }
}
