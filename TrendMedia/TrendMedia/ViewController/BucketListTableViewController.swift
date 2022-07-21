//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/19.
//

import UIKit

class BucketListTableViewController: UITableViewController {
    static var identifier = "BucketListTableViewController"
    
    @IBOutlet weak var userTextField: UITextField!
    
    var list = ["어벤져스", "아바타2", "탑건", "토르"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "AA"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        tableView.rowHeight = 80
        list.append("마녀")
    }
    
    @objc
    func closeButtonClicked() {
        self.dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketListTableViewCell.identifier, for: indexPath) as! BucketListTableViewCell
        cell.bucketListLabel.text = list[indexPath.row]
        //탭바 밑에 11, 네비게이션 Title 17 그 사이 크게 쓰고 싶으면 15 작게 쓰고싶으면 13
        cell.bucketListLabel.font = .boldSystemFont(ofSize: 18)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //우측 스와이프 디폴트 기능: commit editing Style
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            //배열 삭제후 테이블 뷰 갱신
            list.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        //case2.
        if let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) {
            list.append(value)
            tableView.reloadData()
        } else {
            // toast 메시지 띄워주기 등
        }
        
        guard let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count)
        else {
            return
        }
        list.append(value)
        tableView.reloadData()
        
        //Case1.
        //        list.append(sender.text!)
        //        tableView.reloadData()
    }
}
