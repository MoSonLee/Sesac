//
//  LocalizeViewController.swift
//  Sesac2Week9
//
//  Created by 이승후 on 2022/09/06.
//

import UIKit
import MessageUI // 메일로 문의 보내기, 디바이스 테스트, 아이폰 메일 계정을 등록 해야 가능

class LocalizeViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sampleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "naivgation_title".localized
        let buttonTitle = "common_cancel".localized
        sampleButton.setTitle(buttonTitle, for: .normal)
        searchbar.placeholder = "search_placeholder".localized
        inputTextField.placeholder = "textfield_placeholder".localized
        
//        myLabel.text = String(format: NSLocalizedString("introduce", comment: ""), "고래밥")
        myLabel.text = "introduce".localized(with: "고래밥")
        inputTextField.text = "number".localized(number: 10)
        sendMail()
//        inputTextField.text = String(format: NSLocalizedString("number", comment: ""), 10)
        
    }
    
    func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.setToRecipients(["ron22@ron222.com"])
            mail.setSubject("문의사항")
            mail.mailComposeDelegate = self
            
            self.present(mail, animated: true)
    
        } else {
            print("ALERT")
            //alert. 메일 등록을 해주시거나 ,@@@@로 문의 주세요
        }
    }
    
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        switch result {
//        case .cancelled:
//            print("취소")
//        case .saved:
//            
//        case .sent:
//            <#code#>
//        case .failed:
//            <#code#>
//        }
//        controller.dismiss(animated: true)
//    }
}


extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with: String) -> String {
        return String(format: self.localized, with)
    }
    
    func localized(number: Int) -> String {
        return String(format: self.localized, number)
    }
}
