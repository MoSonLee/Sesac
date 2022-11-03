//
//  SubscriptExample.swift
//  SeSACToken
//
//  Created by 이승후 on 2022/11/03.
//

import Foundation

extension String {
    
    // jack >>>> [1] >>>> a
    
    subscript(idx: Int) -> String? {
        guard (0..<count).contains(idx) else {
            return nil
        }
        
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
    }
}
