//
//  ViewController.swift
//  Movie
//
//  Created by 이승후 on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var winter: UIImageView!
    @IBOutlet weak var killer: UIImageView!
    @IBOutlet weak var avatar: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageSet = [winter, killer, avatar]
        for i in 0...imageSet.count - 1 {
            imageSet[i]?.layer.cornerRadius = 60
            imageSet[i]?.layer.borderWidth = 3.0
            imageSet[i]?.layer.borderColor = UIColor.gray.cgColor
        }
    }
}

