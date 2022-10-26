//
//  NewsViewController.swift
//  SeSACWeek1617
//
//  Created by 이승후 on 2022/10/20.
//

import UIKit

import RxSwift

final class NewsViewController: UIViewController {
    @IBOutlet private weak var numberTextField: UITextField!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var resetButton: UIButton!
    @IBOutlet private weak var loadButton: UIButton!
    
    private let viewModel = NewsViewModel()
    private let disposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Int, News.NewsItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        configureDataSource()
        bindData()
        buttonTapped()
        textFieldChanged()
        //        configureViews()
    }
    
    private func bindData() {
        viewModel.pageNumber
            .withUnretained(self)
            .subscribe(onNext: { vc, value in
                print("bind == \(value)")
                vc.numberTextField.text = value
            })
            .disposed(by: disposeBag)
        
        viewModel.sample
            .withUnretained(self)
            .subscribe(onNext: { vc, value in
                var snapshot = NSDiffableDataSourceSnapshot<Int, News.NewsItem>()
                snapshot.appendSections([0])
                snapshot.appendItems(value)
                vc.dataSource.apply(snapshot, animatingDifferences: false)
            })
            .disposed(by: disposeBag)
        //        viewModel.pageNumber.bind { value in
        //            print("bind == \(value)")
        //            self.numberTextField.text = value
        //        }
        
        //        viewModel.sample.bind { item in
        //            var snapshot = NSDiffableDataSourceSnapshot<Int, News.NewsItem>()
        //            snapshot.appendSections([0])
        //            snapshot.appendItems(item)
        //            self.dataSource.apply(snapshot, animatingDifferences: false)
        //        }
    }
    
    //    func configureViews() {
    //        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
    //        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    //        loadButton.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
    //    }
    
    //    @objc func numberTextFieldChanged() {
    //        print(#function)
    //        guard let text = numberTextField.text else { return }
    //        viewModel.changePageNumberFormat(text: text)
    //    }
    
    private func buttonTapped() {
        //        resetButton.rx.tap
        //            .withUnretained(self)
        //            .subscribe {(vc, _ ) in
        //                vc.viewModel.resetSample()
        //            }
        //            .disposed(by: disposeBag)
        //
        //        loadButton.rx.tap
        //            .withUnretained(self)
        //            .subscribe {(vc, _ ) in
        //                vc.viewModel.loadSample()
        //            }
        //            .disposed(by: disposeBag)
        //
        loadButton.rx.tap
            .withUnretained(self)
            .bind {(vc, _ ) in
                vc.viewModel.loadSample()
            }
            .disposed(by: disposeBag)
        
        resetButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.resetSample()
            }
            .disposed(by: disposeBag)
    }
    
    private func textFieldChanged() {
        numberTextField.rx.text.orEmpty
            .withUnretained(self)
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe {(vc, value ) in
                vc.viewModel.changePageNumberFormat(text: value)
            }
            .disposed(by: disposeBag)
    }
}

//    @objc func resetButtonTapped() {
//        viewModel.resetSample()
//    }
//
//    @objc func loadButtonTapped() {
//        viewModel.loadSample()
//    }

extension NewsViewController {
    
    private func configureHierachy() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .lightGray
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration< UICollectionViewListCell, News.NewsItem> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            content.secondaryText = itemIdentifier.body
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}
