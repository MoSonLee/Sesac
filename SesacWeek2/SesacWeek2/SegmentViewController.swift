//
//  SegmentViewController.swift
//  SesacWeek2
//
//  Created by 이승후 on 2022/07/12.
//

import UIKit

enum MusicType: Int {
    case all = 0
    case korea = 1
    case other = 2
}

class SegmentViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControlValuedChanged(segmentControl!)

    }
    

    @IBAction func segmentControlValuedChanged(_ sender: Any) {
        
        if segmentControl.selectedSegmentIndex == MusicType.all.rawValue {
            
        }
            
        
        if segmentControl.selectedSegmentIndex == 0 {
            resultLabel.text = "첫번째 세그먼트 선택"
        } else if segmentControl.selectedSegmentIndex == 1 {
            resultLabel.text = "두번째 세그먼트 선택"
        } else if segmentControl.selectedSegmentIndex == 2{
            resultLabel.text = "세번째 세그먼트 선택"
        } else {
            resultLabel.text = "오류"
        }
    }
    
}
