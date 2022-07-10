//
//  SecondViewController.swift
//  Delivery
//
//  Created by 이승후 on 2022/07/10.
//

import UIKit

final class SecondViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak private var profileImageVIew: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageVIew.layer.cornerRadius = 200
        profileImageVIew.sizeToFit()
    }
}
