//
//  SettingTableViewController.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/18.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    var birthdayFriends = ["MosonLEE", "스노기", "고래"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //섹션의 갯수(옵션)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "생일인 친구"
        } else if section == 1 {
            return "즐겨찾기"
        } else if section == 2 {
            return "친구 140명"
        } else {
            return "오류입니다."
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Footer"
    }
    
    //1. 셀의 갯수
    //ex. 카톡 100명 -> 셀 100개, 200명 -> 셀 200갸
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    //    if section == 0 {
    //        return birthdayFriends.count
    //    } else if section == 1 {
    //        return 2
    //    } else if section == 2 {
    //        return 3
    //    } else {
    //        return 0
    //    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        if indexPath.section == 0 {
            cell.textLabel?.text = birthdayFriends[indexPath.row]
            cell.textLabel?.textColor = .systemMint
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "인덱스 1번째 셀 텍스트"
            cell.textLabel?.textColor = .systemBlue
            cell.textLabel?.font = .boldSystemFont(ofSize: 25)
        } else if indexPath.section == 2 {
            cell.textLabel?.text = "인덱스 2번째 셀 텍스트"
            cell.textLabel?.textColor = .systemPink
            cell.textLabel?.font = .boldSystemFont(ofSize: 30)
        }
        return cell
    }
    override public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let view = view as? UITableViewHeaderFooterView {
            view.backgroundView?.backgroundColor = UIColor.blue
            view.textLabel?.backgroundColor = UIColor.clear
            view.textLabel?.textColor = UIColor.red
            view.textLabel?.font = .preferredFont(forTextStyle: .caption2, compatibleWith: .none)
        }
    }
    //2. 셀의 디자인과 데이터(필수)
    //ex. 카톡 프로필 사진, 상태 메시지 등
}
