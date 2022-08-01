//
//  BeerViewController.swift
//  SeSacNetworkBasic
//
//  Created by 이승후 on 2022/08/01.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class BeerViewController: UIViewController {
    
    @IBOutlet weak private var randomButton: UIButton!
    @IBOutlet weak private var beerDescriptionTextView: UITextView!
    @IBOutlet weak private var beerImage: UIImageView!
    
    @IBOutlet weak private var beerNameLabel: UILabel!
    @IBOutlet weak private var beerBoilVolume: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestBeer()
        setViewWithComponets()
    }
    
    private func requestBeer() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.beerDescriptionTextView.text = json[0]["description"].stringValue
                self.beerNameLabel.text = json[0]["name"].stringValue
                self.beerDescriptionTextView.text = json[0]["description"].stringValue
                self.beerBoilVolume.text =  String(json[0]["boil_volume"]["value"].intValue) + json[0]["volume"]["unit"].stringValue
                let imageURL = json[0]["image_url"].url
                let errorURL = URL(string: "https://www.geochang.go.kr/portal/popup/20190111/20190111.gif")
                if imageURL == nil {
                    self.beerImage.kf.setImage(with: errorURL )
                } else {
                    self.beerImage.kf.setImage(with: imageURL)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setViewWithComponets() {
        view.backgroundColor = .systemMint
        randomButton.layer.borderWidth = 1
        randomButton.backgroundColor = .systemRed
        randomButton.setTitle("랜덤", for: .normal)
        randomButton.tintColor = .darkText
        
        beerDescriptionTextView.layer.borderWidth = 1
        
        beerNameLabel.backgroundColor = .white
        beerNameLabel.textAlignment = .center
        beerNameLabel.textColor = .systemRed
        
        beerBoilVolume.textAlignment = .center
        beerBoilVolume.textColor = .systemBlue
        beerBoilVolume.backgroundColor = .white
    }
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        requestBeer()
    }
}
