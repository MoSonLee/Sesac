//
//  TrendTableViewController.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/21.
//

import UIKit

class TrendTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func movieButtonTapped(_ sender: UIButton) {
        //영화버튼 클릭 > BucketListTableViewController Present
        // 화면 전환: 1. 스토리보드 파일 찾기 -> 2. 스토리보드 내에 뷰컨트롤러 찾기 -> 3, 화면전환
        //1.
        let storyboard = UIStoryboard(name: "Trend", bundle: nil)
        //2.
        let vc = storyboard.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        self.present(vc, animated: true)
        
        
        
    }
    
    @IBAction func dreamButtonClicked(_ sender: UIButton) {
        //영화버튼 클릭 > BucketListTableViewController Present
        // 화면 전환: 1. 스토리보드 파일 찾기 -> 2. 스토리보드 내에 뷰컨트롤러 찾기 -> 3, 화면전환
        //1.
        let storyboard = UIStoryboard(name: "Trend", bundle: nil)
        //2.
        let vc = storyboard.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        //2.5
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func bookButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Trend", bundle: nil)
        //2.
        let vc = storyboard.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        //2.5
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
}
