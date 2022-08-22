//
//  TableModel.swift
//  SeSacRealmAssignment
//
//  Created by 이승후 on 2022/08/22.
//

import Foundation

struct TableModel {
    var checkButtonString: String
    var labelText: String
    var starButtonString: String
}

struct TableModelData {
    let tableCellArray: [TableModel] = [
        TableModel(checkButtonString: "checkmark.square", labelText: "아이폰 구매하기", starButtonString: "star"),
        TableModel(checkButtonString: "checkmark.square", labelText: "맥북 구매하기", starButtonString: "star"),
        TableModel(checkButtonString: "checkmark.square", labelText: "아이패드 구매하기", starButtonString: "star"),
        TableModel(checkButtonString: "checkmark.square", labelText: "아이맥 구매하기", starButtonString: "star")
    ]
}
