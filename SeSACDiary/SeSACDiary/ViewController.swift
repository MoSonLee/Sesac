//
//  ViewController.swift
//  SeSACDiary
//
//  Created by 이승후 on 2022/08/16.
//

import UIKit
import MosonLeeFramework

final class ViewController: UIViewController {
    
    private var name = "고래밥"
    private var age = 22
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = CodeSnap2ViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
        //        testOpen()
        //        showSesacAlert(title: "테스트 얼럿", message: "테스트 메시지", buttonTitle: "변경") { _ in
        //            self.view.backgroundColor = .lightGray
        //        }
        //            let image = UIImage(systemName: "star.fill")!
        //            let shareURL = "https://www.apple.com"
        //            let text = "WWDC What's NEW!!a"
        //            sesacShowActivityViewController(shareImage: image, shareURL: shareURL, shareText: text)
        OpenWebView.presentWebViewController(self, url: "https://www.naver.com", transitionStyle: .present)
    }
}

