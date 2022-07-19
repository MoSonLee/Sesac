//
//  ShoppingModel.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/19.
//

import UIKit

public var arrayList = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "양말"]

enum ShoppingList: Int, CaseIterable {
    case shopList
    var rowTitle: [String] {
        switch self {
        case .shopList:
            return arrayList
        }
    }
}
