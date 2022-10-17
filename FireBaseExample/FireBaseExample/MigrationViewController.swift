//
//  MigrationViewController.swift
//  FireBaseExample
//
//  Created by 이승후 on 2022/10/13.
//

import UIKit
import RealmSwift

class MigrationViewController: UIViewController {
    
    let localRealm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. fileURL
        print("FileURL: \(localRealm.configuration.fileURL!)")
        
        //2. Scheme Version
        do {
            let version = try schemaVersionAtURL(localRealm.configuration.fileURL!)
            print("Scheme Version: \(version)")
        } catch {
            print(error)
        }
        
        for i in 1...100 {
            let task = Todo(title: "나쵸의 할일 \(i)", importance: Int.random(in: 1...5))

            try! localRealm.write {
                localRealm.add(task)
            }
        }
        
//        for i in 1...10 {
//            let task = DetailTodo(detailTitle: "치즈 나쵸의 할일 \(i)", favorite: true)
//            try! localRealm.write {
//                localRealm.add(task)
//            }
//        }
        
        //특정 Todo 테이블에 DetailToDo 추가
        guard let task = localRealm.objects(Todo.self).filter("title = '나쵸의 할일 7'").first else { return }
        
        let detail = DetailTodo(detailTitle: "소스에 찍어먹기", favorite: false)
        
        try! localRealm.write {
            task.detail.append(detail)
        }
        
        guard let task = localRealm.objects(Todo.self).filter("title = '나쵸의 할일 7'").first else { return }
        try! localRealm.write {
            localRealm.delete(task.detail)
            localRealm.delete(task)
        }
        
        // 특정 Todo에 메모 추가
        guard let task = localRealm.objects(Todo.self).filter("title = '나쵸의 할일 6'").first else { return }
        
        let memo = Memo()
        memo.content = "이렇게 메모 내용을 추가해봅니다."
        memo.date = Date()
        
        try! localRealm.write {
            task.Memo = memo
        }
    }
}
