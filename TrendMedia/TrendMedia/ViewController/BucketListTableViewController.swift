//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/19.
//

import UIKit

struct Todo {
    var title: String
    var done: Bool
}

class BucketListTableViewController: UITableViewController {
    static var identifier = "BucketListTableViewController"
    
    @IBOutlet weak var userTextField: UITextField!
    
    // List 프로퍼티가 추가, 삭제 등 변경 되고 나서 테이블뷰를 항상 갱신해줘야함!
    //    var list = ["어벤져스", "아바타2", "탑건", "토르"] {
    //        didSet {
    //            tableView.reloadData()
    //            print("리스트가 변경됨 \(list), \(oldValue)")
    //        }
    //    }
    
    var list = [Todo(title: "범죄도시2", done: false), Todo(title: "탑거", done: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "AA"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        tableView.rowHeight = 80
        //        list.append("마녀")
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
        cell.bucketListLabel.text = list[indexPath.row].title
        //탭바 밑에 11, 네비게이션 Title 17 그 사이 크게 쓰고 싶으면 15 작게 쓰고싶으면 13
        cell.bucketListLabel.font = .boldSystemFont(ofSize: 18)
        
        cell.checkboxButton.tag = indexPath.row
        cell.checkboxButton.addTarget(self, action: #selector(checkboxButtonClicked), for: .touchUpInside)
        
        let value = list[indexPath.row].done ? "checkmark.square.fill" : "checkmark.square"
        cell.checkboxButton.setImage(UIImage(systemName: value), for: .normal)
        return cell
    }
    
    @objc func checkboxButtonClicked(sender: UIButton) {
        print("\(sender.tag)번째 버튼 클릭!")
        list[sender.tag].done = !list[sender.tag].done
//        tableView.reloadData()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
//        list[sender.tag].done ? sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal) : sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
//        list[sender.tag].done = !list[sender.tag].done
        //        sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
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
        //        if let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) {
        //            list.append(value)
        //            tableView.reloadData()
        //        } else {
        //            // toast 메시지 띄워주기 등
        //        }
        //
        //        guard let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count)
        //        else {
        //            return
        //        }
        list.append(Todo(title: sender.text!, done: false))
        tableView.reloadData()
        
        //Case1.
        //        list.append(sender.text!)
        //        tableView.reloadData()
    }
}
