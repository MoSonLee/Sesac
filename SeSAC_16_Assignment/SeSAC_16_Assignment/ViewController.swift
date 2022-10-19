//
//  ViewController.swift
//  SeSAC_16_Assignment
//
//  Created by 이승후 on 2022/10/19.
//

import UIKit

import SnapKit

final class ViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    private var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, appleStore>!
    private var dataSource: UICollectionViewDiffableDataSource<Int, appleStore>!
    
    struct appleStore: Hashable {
        let id = UUID().uuidString
        let name: String
        let price: String
    }
    
    var list = [
        appleStore(name: "iphone", price: "1000Dollar"),
        appleStore(name: "ipad", price: "1500Dollar"),
        appleStore(name: "appleWatch", price: "500Dollar"),
        appleStore(name: "macBook", price: "10000Dollar"),
        appleStore(name: "mackBookPro", price: "15000Dollar")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setComponents()
        setConstraints()
        collectionView.delegate = self
        searchBar.delegate = self
        configureDataSource()
    }
    
    private func setComponents() {
        view.backgroundColor = .lightGray
        [searchBar, collectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        collectionView.backgroundColor = .systemGray
    }
    
    private func setConstraints() {
        collectionView.collectionViewLayout = createLayout()
        
        searchBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([appleStore(name: searchBar.text!, price: "not provided")])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController {
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemGray
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegsteration = UICollectionView.CellRegistration<UICollectionViewListCell, appleStore>(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.secondaryText = itemIdentifier.price
            cell.contentConfiguration = content
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.strokeWidth = 2
            background.strokeColor = .black
            cell.backgroundConfiguration = background
        })
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegsteration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, appleStore>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        dataSource.apply(snapshot)
    }
}
