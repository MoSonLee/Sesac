//
//  ViewController.swift
//  Movie
//
//  Created by 이승후 on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageViewList: [UIImageView]!
    let imageList = ["Image0", "Image1", "Image2", "Image3", "Image4", "Image5", "Image6", "Image7", "Image8", "Image9"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // image를 좀 더 쉽게 추가하는 법
        //        for i in 0..<10 {
        //         imageList2.append("Image" + "\(i)")
        //        }
        for i in 1...imageViewList.count - 1 {
            imageViewList[i].layer.cornerRadius = 60
            imageViewList[i].layer.borderColor = UIColor.red.cgColor
            imageViewList[i].layer.borderWidth = 1.0
        }
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        imageViewList.forEach {
            $0.image = UIImage(named: imageList.randomElement()!)
        }
        // 이미지 중복되지 않게 바꾸는 코드
        let random3ImageList = imageList.shuffled().prefix(imageViewList.count)
        for index in 0 ..< imageViewList.count {
            imageViewList[index].image = UIImage(named: random3ImageList[index])
        }
    }
}





