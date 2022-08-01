//
//  Constant.swift
//  SeSacNetworkBasic
//
//  Created by 이승후 on 2022/08/01.
//

import Foundation

//enum StorybordName: String {
//    case Main
//    case Search
//    case Setting
//}

struct StorybordName {
    // 접근 제어를 통한 초기화 방지
    static let main = "Main"
    static let search = "Search"
    static let setting = "Setting"
}

/*
 1. struct type property vs enum type property -> 인스턴스 생성 방지
 2. enum case vs enum static ->
 */

//enum StorybordName {
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//}

enum fontName {
    static let title = "SanFransisco"
    static let body = "SanFransisco2"
    static let caption = "AppleSndol"
}
