//
//  TrendMediaModel.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/18.
//

import Foundation

enum SettingOptions: Int, CaseIterable {
    case total, personal, others
    //section
    var sectionTitle: String {
        switch self {
        case .total:
            return "전체 설정"
        case .personal:
            return "개인 설정"
        case .others:
            return "기타"
        }
    }
    //cell
    var rowTitle: [String] {
        switch self {
        case .total:
            return ["공지사항", "실험실", "버전 정보"]
        case .personal:
            return ["개인/보안", "알림", "채팅", "멀티프로필"]
        case .others:
            return ["고객센터/도움말"]
        }
    }
}
