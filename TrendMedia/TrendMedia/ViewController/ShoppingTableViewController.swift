//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/19.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak private var textFieldView: UIView!
    @IBOutlet weak private var addButton: UIButton!
    var shopArray: [String] = arrayList
    
    //    public var shopViewModel = ShoppingModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.setButtonLayout()
        textField.borderColor()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingList.allCases[section].rowTitle.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        
        cell.label?.text = ShoppingList.allCases[indexPath.section].rowTitle[indexPath.row]
        cell.leftButton?.tintColor = .black
        cell.rightButton?.tintColor = .black
        cell.leftButton?.setTitle("", for: .normal)
        cell.rightButton?.setTitle("", for: .normal)
        cell.leftButton?.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        cell.rightButton?.setImage(UIImage(systemName: "star"), for: .normal)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //우측 스와이프 디폴트 기능: commit editing Style
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //배열 삭제후 테이블 뷰 갱신
            arrayList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        arrayList.append(sender.text!)
        showAlert(alertTitle: "추가 완료", alertMessage: "확인")
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        arrayList.append(textField.text!)
        showAlert(alertTitle: "추가 완료", alertMessage: "확인")
        tableView.reloadData()
    }
}
