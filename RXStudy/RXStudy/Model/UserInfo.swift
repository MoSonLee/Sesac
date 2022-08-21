//
//  UserInfo.swift
//  RXStudy
//
//  Created by 이승후 on 2022/08/21.
//

import Foundation

struct UserAccounts: Decodable{

    let userName: String
    let hash: String
    let accounts: [Account]
}

struct Account: Decodable {

    let accountID: Int
    let name: String
    let numberFormat: String
    let evaluation: Int
    let message: String
    let badge: String
}
