//
//  RandomPhotoViewController.swift
//  SeSAC_16_Assignment
//
//  Created by 이승후 on 2022/10/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class RandomPhotoViewController: UIViewController, UICollectionViewDelegate {
    
    private var viewModel = RandomPhotoViewModel()
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    private var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, RandomPhoto>!
    private var dataSource: UICollectionViewDiffableDataSource<Int, RandomPhoto>!
    var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
    private let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.requestRandomPhoto()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createLayout()
        setComponents()
        setConstraints()
        configureDataSource()
        collectionView.delegate = self
        
        viewModel.randomPhotoList
            .withUnretained(self)
            .subscribe { (vc, randomPhoto) in
                var snapshot = NSDiffableDataSourceSnapshot<Int, RandomPhoto>()
                snapshot.appendSections([0])
                snapshot.appendItems([randomPhoto])
                vc.dataSource.apply(snapshot)
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
//        viewModel.randomPhotoList.bind { randomPhoto in
//            var snapshot = NSDiffableDataSourceSnapshot<Int, RandomPhoto>()
//            snapshot.appendSections([0])
//            snapshot.appendItems([randomPhoto])
//            self.dataSource.apply(snapshot)
//        }
    }
    
    private func setComponents() {
        view.backgroundColor = .lightGray
        [collectionView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setConstraints() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension RandomPhotoViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegsteration = UICollectionView.CellRegistration<UICollectionViewListCell, RandomPhoto>(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.likes)개"
            
            //이쪽도 Rx로 바꿀 수 있을까?
            DispatchQueue.global().async {
                guard let url = URL(string: itemIdentifier.urls.thumb) else { return }
                let data = try? Data(contentsOf: url)
                
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
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegsteration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}
