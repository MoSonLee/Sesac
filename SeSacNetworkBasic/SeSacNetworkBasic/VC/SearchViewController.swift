//
//  SearchViewController.swift
//  SeSacNetworkBasic
//
//  Created by 이승후 on 2022/07/27.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ViewPresentableProtocl {
    
    var navigationTitleString: String = ""
    
    var backgroundColor = UIColor.red
    
    static var identifier =  "SearchViewController"
    
    
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 연결고리 작업: 테이블 뷰가 해야할 역할 > 뷰 컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        //테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        //XIB: xml interface builder <= NIB
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
    }
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
    func configureLabel() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell()}
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "HELLO"
        return cell
    }
}
