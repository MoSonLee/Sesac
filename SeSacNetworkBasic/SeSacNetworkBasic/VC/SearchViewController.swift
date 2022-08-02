//
//  SearchViewController.swift
//  SeSacNetworkBasic
//
//  Created by 이승후 on 2022/07/27.
//

import UIKit

import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ViewPresentableProtocl {
    
    var navigationTitleString: String = ""
    var backgroundColor = UIColor.red
    static var identifier =  "SearchViewController"
    var list: [BoxOfficeModel] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 연결고리 작업: 테이블 뷰가 해야할 역할 > 뷰 컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        //테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        //XIB: xml interface builder <= NIB
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        searchBar.delegate = self
        requestBoxOffice(text: "20220801")
    }
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
    func configureLabel() {
        
    }
    
    func requestBoxOffice(text: String) {
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f709307fc0f744f0b16793718bee4510&targetDt=\(text)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                self.list.removeAll()
                let json = JSON(value)
                print("JSON: \(json)")
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let movieNM = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    
                    let data = BoxOfficeModel(movieTitle: movieNM, releaseDate: openDt, totalCount: audiAcc)
                    
                    self.list.append(data)
                }
                print(self.list)
                
//                let movieNum1 = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
//                let movieNum2 = json["boxOfficeResult"]["dailyBoxOfficeList"][1]["movieNm"].stringValue
//                let movieNum3 = json["boxOfficeResult"]["dailyBoxOfficeList"][2]["movieNm"].stringValue
                
//                self.list.append(movieNum1)
//                self.list.append(movieNum2)
//                self.list.append(movieNum3)
                
                self.searchTableView.reloadData()
                print(self.list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell()}
        
        cell.backgroundColor = .clear
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "\(list[indexPath.row].movieTitle): \(list[indexPath.row].releaseDate)"
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestBoxOffice(text: searchBar.text!)
    }
}
