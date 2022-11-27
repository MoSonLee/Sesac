//
//  SimpleCollectionViewController.swift
//  FireBaseExample
//
//  Created by 이승후 on 2022/10/18.
//

import UIKit
import RealmSwift

class SimpleCollectionViewController: UICollectionViewController {
    
    var tasks: Results<Todo>!
    let localRealm = try! Realm()
    
    //4번 cell에 등록
    var cellRegisteration: UICollectionView.CellRegistration<UICollectionViewListCell, Todo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = localRealm.objects(Todo.self)
        
        //1번 configuration
        let configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        //2번 layout
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        //3번 layout 적용
        collectionView.collectionViewLayout = layout
        
        //5번 데이터들 넣어줌
        cellRegisteration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = cell.defaultContentConfiguration()
            content.image = itemIdentifier.importance < 2 ? UIImage(systemName: "person.fill") : UIImage(systemName: "person.2.fill")
            content.text = itemIdentifier.title
            content.secondaryText = "\(itemIdentifier.detail.count)개의 세부 항목"
            
            cell.contentConfiguration = content
        })
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = tasks[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: item)
        
        var test: food = apple()
        test = banana()
        return cell
    }
}

class food {
    
}

protocol fruit {
    
}

class apple: food, fruit {
    
}

class banana: food, fruit {
    
}

class strawberry: fruit {
    
}

struct melon: fruit {
    
}
