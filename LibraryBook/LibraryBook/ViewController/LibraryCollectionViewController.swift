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
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.book.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryCollectionViewCell", for: indexPath) as! LibraryCollectionViewCell
        let data = bookList.book[indexPath.row]
        cell.backgroundColor = randomColorArray.randomElement()
        cell.bookImage.kf.setImage(with: bookImageURLArray[indexPath.row])
        cell.configureCell(data)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = bookList.book[indexPath.row]
        view.makeToast("\(data.title)의 평점은 \(data.rate)입니다.", duration: 2, position: .bottom)
        view.backgroundColor = randomColorArray.randomElement()
        collectionView.reloadData()
    }
}
