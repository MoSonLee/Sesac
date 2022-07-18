//
//  TrendMediaTableViewController.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/18.
//

import UIKit

class TrendMediaTableViewController: UITableViewController {
    private var viewModel = trendMediaModel()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.settingTextArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for index in 0..<viewModel.settingTextArray.count {
            if section == index {
                return viewModel.settingTextArray[section].count
            }
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        for index in 0..<viewModel.settingTextArray.count {
            if indexPath.section == index {
                cell.textLabel?.text = viewModel.settingTextArray[index][indexPath.row]
            }
        }
        cell.backgroundColor = .white
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.textColor = .black
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        for index in 0..<viewModel.headerArray.count {
            if section == index {
                return viewModel.headerArray[index]
            }
        }
        return nil
    }
}
