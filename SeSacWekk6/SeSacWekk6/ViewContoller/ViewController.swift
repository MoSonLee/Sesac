//
//  ViewController.swift
//  SeSacWekk6
//
//  Created by 이승후 on 2022/08/08.
//

import UIKit
//import SwiftyJSON

/*
 1. html tag <> </> 기능활용
 2. 문자열 대체 메서드
 */

/*
 TableView automaticDimension
 - 컨텐츠 양에 따라서 셀 높이가 자유롭게
 - 조건: 레이블 numberOfLines 0
 - 조건: TalbeView height automatic dimension
 - 조건: 레이아웃을 잘 잡아야됨
 */

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var blogList: [String] = []
    private var cafeList: [String] = []
    var isExapnded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBlog()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension // 모든 섹션의 셀에 대해서 유동적!
    }
    @IBAction func expandButton(_ sender: Any) {
        isExapnded = !isExapnded
        tableView.reloadData()
    }
    
    private func searchBlog() {
        KaKaoAPIManager.shared.callRequest(type: .blog, query: "고래밥") { json in
            for item in json["documents"].arrayValue {
                let value = item["contents"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                self.blogList.append(value)
            }
            self.searchCafe()
        }
    }
    
    private func searchCafe() {
        KaKaoAPIManager.shared.callRequest(type: .cafe, query: "고래밥") { json in
            for item in json["documents"].arrayValue {
                let value = item["contents"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                self.cafeList.append(value)
            }
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? blogList.count : cafeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "kakaoCell", for: indexPath) as? kakaoCell else { return UITableViewCell() }
        cell.testLabel.text = indexPath.section == 0 ? blogList[indexPath.row] : cafeList[indexPath.row]
        cell.testLabel.numberOfLines = isExapnded ? 0 : 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  section == 0 ? "블로그 검색결과" : "카페 검색결과"
    }
}

final class kakaoCell: UITableViewCell {
    @IBOutlet weak var testLabel: UILabel!
}
