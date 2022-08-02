//
//  Constant.swift
//  SeSacNetworkBasic
//
//  Created by 이승후 on 2022/08/01.
//

import Foundation

struct APIKey {
    static let BOXOFFICE = "f709307fc0f744f0b16793718bee4510"
    static let NAVER_ID = "tSUzT1r164LmbgFXn59B"
    static let NAVER_SecretID = "rtxl2UV_IV"
}

struct EndPoint {
    static let boxOfficeURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    static let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber"
    static let translateURL = "https://openapi.naver.com/v1/papago/n2mt"
}

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
