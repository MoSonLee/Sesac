//
//  SimpleCollectionViewController.swift
//  SeSACWeek1617
//
//  Created by 이승후 on 2022/10/18.
//

import UIKit

struct User: Hashable {
    let id = UUID().uuidString
    let name: String //hashable
    let age: Int // hashable
}

class SimpleCollectionViewController: UICollectionViewController {
    
    //    var list = ["닭곰탕", "삼계탕", "들기름김", "삼분카레", "콘소메 치킨"]
    
    var list = [
        User(name: "뽀로로", age: 3),
        User(name: "에디", age: 13),
        User(name: "해리포터", age: 33),
        User(name: "도라에몽", age: 5),
    ]
    
    //cellForItemAt 전에 생성되어야 한다.
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    var dataSource: UICollectionViewDiffableDataSource<Int, User>!
    
    var hello: (() -> Void)!
    
    func welcome() {
        print("hello")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hello = welcome //welcome vs welcome()
        hello()
        
        collectionView.collectionViewLayout = createLayout()
        
        //1. Identifier 2. struct 단위로 등록됨
        
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            //            var content = cell.defaultContentConfiguration()
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.secondaryText = "\(itemIdentifier.age)살"
            //default가 true secondarytext 위치 변경
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 20
            content.textProperties.color = .red
            content.image = itemIdentifier.age < 8 ? UIImage(systemName: "person.fill") : UIImage(systemName: "star")
            content.imageProperties.tintColor = .yellow
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .lightGray
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeColor = .systemPink
            backgroundConfig.strokeWidth = 1
            cell.backgroundConfiguration = backgroundConfig
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, User>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    //    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //        return list.count
    //    }
    //
    //    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //        let item = list[indexPath.item]
    //        // using: UICollectionView.CellRegistration<Cell, Item> 에서의 Cell은 Cell 타입, Item은 내용물으 의미한다.
    //        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
    //        return cell
    //    }
}

extension SimpleCollectionViewController {
    private func createLayout() -> UICollectionViewLayout {
        //14+ 컬렉션뷰를 테이블뷰 스타일처럼 사용가능(List Configuration)
        //컬렉션뷰 스타일(셀 X)
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .brown
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}
