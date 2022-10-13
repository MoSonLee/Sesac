//
//  Todo.swift
//  FireBaseExample
//
//  Created by 이승후 on 2022/10/13.
//

import Foundation
import RealmSwift

class Todo: Object {
    @Persisted var title: String
    @Persisted var importance2: Double
    @Persisted var userDescription: String
    @Persisted var count: Int
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(title: String, importance: Int) {
        self.init()
        self.title = title
        self.importance2 = Double(importance)
    }
}
