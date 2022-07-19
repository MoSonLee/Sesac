//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/19.
//

import UIKit

class BucketListTableViewController: UITableViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    var list = ["어벤져스", "아바타2", "탑건", "토르"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        list.append("마녀")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BucketListTableViewCell", for: indexPath) as! BucketListTableViewCell
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
        list.append(sender.text!)
        //중요!!
        tableView.reloadData()
    }
}
