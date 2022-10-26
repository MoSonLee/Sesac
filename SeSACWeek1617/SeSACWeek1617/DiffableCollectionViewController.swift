//////
//////  DiffableCollectionViewController.swift
//////  SeSACWeek1617
//////
//////  Created by 이승후 on 2022/10/19.
//////

import UIKit

import RxCocoa
import RxSwift

final class DiffableCollectionViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    private let viewModel = DiffableViewModel()
    private let disoseBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Int, SearchResult>! // = <섹션, 데이터> 에 대한 정보
    //private var cellRegsteration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        setDelegate()
        bindData()
    }
    
    private func bindData() {
        
        viewModel.photoList
            .withUnretained(self)
            .subscribe(onNext: {  (vc, photo) in
                var snapshot = NSDiffableDataSourceSnapshot<Int, SearchResult>()
                snapshot.appendSections([0])
                snapshot.appendItems(photo.results)
                vc.dataSource.apply(snapshot)
            }, onError: { error in
                print("========error: \(error)")
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            })
            .disposed(by: disoseBag)
        
        searchBar.rx.text.orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe { (vc, value) in
                vc.viewModel.requestSearchPhoto(query: value)
            }
            .disposed(by: disoseBag)
    }
//        viewModel.photoList.bind { photo in
//            var snapshot = NSDiffableDataSourceSnapshot<Int, SearchResult>()
//            snapshot.appendSections([0])
//            snapshot.appendItems(photo.results)
//            self.dataSource.apply(snapshot)
//        }
    
    private func setDelegate() {
        collectionView.delegate = self
//        searchBar.delegate = self
    }
}

extension DiffableCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        let alert = UIAlertController(title: "\(item.likes)개", message: "클릭!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

//extension DiffableCollectionViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        viewModel.requestSearchPhoto(query: searchBar.text!)
//    }
//}

extension DiffableCollectionViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
        // cellRegsteration 을 전역에 선언하지 않고, 바로 초기화 하면서 handler 앞에 제네릭 명시
        let cellRegsteration = UICollectionView.CellRegistration<UICollectionViewListCell, SearchResult>(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.likes)개"
            
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.thumb)
                let data = try? Data(contentsOf: url!)
                
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content
                }
            }
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.strokeWidth = 2
            background.strokeColor = .systemBlue
            cell.backgroundConfiguration = background
        })
        // numberOfItemsInSection, cellForItemAt 를 아래의 메서드로 대체
        // collectionView.dataSource = self 도 필요 X
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegsteration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}
