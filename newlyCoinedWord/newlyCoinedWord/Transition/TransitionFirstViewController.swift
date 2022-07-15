//
//  TransitionFirstViewController.swift
//  newlyCoinedWord
//
//  Created by 이승후 on 2022/07/15.
//

import UIKit

class TransitionFirstViewController: UIViewController {
    
    @IBOutlet weak var randomNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        
        randomNumberLabel.text = "\(Int.random(in: 1...1000))"
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    @IBAction func unwindTransitionFirstVC(MosonSegue: UIStoryboardSegue) {
        
    }
    
    
}
