//
//  ViewController.swift
//  Movie
//
//  Created by 이승후 on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstThumbnailImageView: UIImageView!
    @IBOutlet weak var secondThumbnailImageView: UIImageView!
    @IBOutlet weak var thirdThumbnailImageView: UIImageView!
    @IBOutlet weak var mainPosterImageView: UIImageView!
    let imageList = ["Image0", "Image1", "Image2", "Image3", "Image4", "Image5", "Image6", "Image7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageSet = [firstThumbnailImageView, secondThumbnailImageView, thirdThumbnailImageView]
        for i in 0...imageSet.count - 1 {
            imageSet[i]?.layer.cornerRadius = 45
            imageSet[i]?.layer.borderWidth = 1.0
            imageSet[i]?.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        mainPosterImageView.image = UIImage(named: imageList.randomElement()!)
        firstThumbnailImageView.image = UIImage(named:imageList.randomElement()!)
        secondThumbnailImageView.image = UIImage(named:imageList.randomElement()!)
        thirdThumbnailImageView.image = UIImage(named: imageList.randomElement()!)
    }
}

