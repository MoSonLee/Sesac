//
//  LibraryCollectionViewController.swift
//  LibraryBook
//
//  Created by 이승후 on 2022/07/20.
//

import UIKit
import Kingfisher
import Toast

private let reuseIdentifier = "Cell"

class LibraryCollectionViewController: UICollectionViewController {
    
    private var bookList = BookInfo()
    private var randomColorArray: [UIColor] = [.systemCyan, .systemRed, .systemPurple, .systemPink, .systemMint, .systemBlue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = collectionView.setCoolectionViewLayout(bookList.book.count)
        setNavigationItem()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.book.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryCollectionViewCell", for: indexPath) as? LibraryCollectionViewCell
        else { return UICollectionViewCell() }
        cell.backgroundColor = randomColorArray.randomElement()
        let data = bookList.book[indexPath.row]
        cell.bookImage.kf.setImage(with: bookImageURLArray[indexPath.row])
        cell.configureCell(data)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "LibraryStoryboard", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: SearchBookViewController.identifier) as? SearchBookViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        view.backgroundColor = randomColorArray.randomElement()
        self.present(nav, animated: true)
    }
    
    private func setNavigationItem() {
        navigationItem.rightBarButtonItem?.title = "검색화면"
        navigationItem.rightBarButtonItem?.tintColor = .systemRed
    }
    
    @IBAction func navigationRightButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "LibraryStoryboard", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: SearchBookViewController.identifier) as? SearchBookViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    @IBAction func moveToBookInfoButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "LibraryStoryboard", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: BookInfoViewController.identifier) as? BookInfoViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true)
    }
}
