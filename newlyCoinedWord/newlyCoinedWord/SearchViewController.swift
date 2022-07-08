//
//  SearchViewController.swift
//  newlyCoinedWord
//
//  Created by 이승후 on 2022/07/08.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let viewModel = wordModel()
    @IBOutlet weak private var textField: UITextField!
    @IBOutlet private var buttonArray: [UIButton]!
    @IBOutlet weak private var label: UILabel!
    @IBOutlet weak private var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.layer.borderWidth = 3
        for i in 0..<buttonArray.count {
            buttonArray[i].layer.borderWidth = 1
            buttonArray[i].layer.cornerRadius = 10
        }
        
    }
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        for i in 0..<viewModel.newWordDictionary.keys.count {
            if textField.text == viewModel.newWordKeys[i] {
                label.text = viewModel.newWordDictionary[textField.text!]
            }
            view.endEditing(true)
        }
    }
    
    @IBAction func returnKeyTapped(_ sender: UITextField) {
        for i in 0..<viewModel.newWordDictionary.keys.count {
            if textField.text == viewModel.newWordKeys[i]  {
                label.text = viewModel.newWordDictionary[textField.text!]
            }
        }
        view.endEditing(true)
    }
    
    @IBAction private func backgroundTapKeybordDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

