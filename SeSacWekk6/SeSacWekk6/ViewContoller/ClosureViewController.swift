//
//  ClosureViewController.swift
//  SeSacWekk6
//
//  Created by 이승후 on 2022/08/08.
//

import UIKit

class ClosureViewController: UIViewController {
    
    @IBOutlet weak var cardView: CardView!
    
    var sampleButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //위치 크기 추가
        /*
         오토리사이징을 오토레이아웃 제약조건처럼 설정해주는 기능이 내부적으로 구현되어 있음
         이 기능은 디폴트가 true, 하지만 오토레이아웃을 지정해주면 오토리사이징을 안 쓰겠다는 의미인 false로 상태가 내부적으로 변경도김
         오토리사징 + 오토레이아웃 = 충돌
         코드 기반 UI > true
         인터페이스 기반 UI > False
         autoresizing > autolayout constraints
         */
        cardView.cardImageView.backgroundColor = .red
        cardView.likeButton.backgroundColor = .yellow
        cardView.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        
        print(sampleButton.translatesAutoresizingMaskIntoConstraints)
        print(cardView.translatesAutoresizingMaskIntoConstraints)
        sampleButton.frame = CGRect(x: 100, y: 400, width: 100, height: 100)
        sampleButton.backgroundColor = .blue
        view.addSubview(sampleButton)
    }
    
    @objc func likeButtonClicked() {
        print("버튼 클릭")
    }
    
    @IBAction func colorPickerButtonClicked(_ sender: UIButton) {
        showAlert(title: "컬러피커를 띄우겠습니까?", message: "", okTitle: "띄우기") {
            let picker = UIColorPickerViewController()
            self.present(picker, animated:  true)
            
        }
    }
    
    @IBAction func backgroundColorChanged(_ sender: UIButton) {
        showAlert(title: "배경색 변경", message: "배경색을 바꾸시겠습니까?", okTitle: "바꾸기") {
            self.view.backgroundColor = .systemGray
        }
    }
}

extension UIViewController {
    func showAlert(title: String, message: String, okTitle: String, okAction: @escaping () -> () ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .default)
        let ok = UIAlertAction(title: okTitle, style: .default) { action in
            okAction()
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
