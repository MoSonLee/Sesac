//
//  sesacWeek9.swift
//  
//
//  Created by 이승후 on 2022/08/29.
//

import UIKit

let json = """
{
"quote": "Count your age by friends, not years. Count your life by smiles, not tears.",
"author": "John Lennon"
}
"""

struct Quote: Decodable {
    let quote: String
    let author: String
}
