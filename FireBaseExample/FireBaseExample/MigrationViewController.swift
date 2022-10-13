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
    }
}
