//
//  RealmModel.swift
//  SeSacRealmAssignment
//
//  Created by 이승후 on 2022/08/23.
//

import Foundation
import RealmSwift

class userBuyList: Object {
    
    @Persisted var buyList: String
    @Persisted var isStarred: String
    @Persisted var isChecked: String
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(buyList: String, isStarred: String, isChecked: String) {
        self.init()
        self.buyList = buyList
        self.isStarred = isStarred
        self.isChecked = isChecked
    }
}
