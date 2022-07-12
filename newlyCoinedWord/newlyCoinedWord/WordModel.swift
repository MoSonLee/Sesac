//
//  wordModel.swift
//  newlyCoinedWord
//
//  Created by 이승후 on 2022/07/09.
//

import Foundation

struct WordModel {
    let newWordDictionary = [
        "만반잘부" : "만나서 반가워 잘 부탁해",
        "윰차" : "유무차별",
        "꾸안꾸" : "꾸민듯 안 꾸밈",
        "실매" : "실시간 매니저",
        "삼귀자" : "연애를 시작하기 전 썸 단계!",
        "할많하않" : "할말은 많지만 하지 않는다."
    ]
    
    let newWordKeys = ["만반잘부", "윰차", "꾸안꾸", "실매", "삼귀자", "할많하않"]
}

enum WordModel2: String {
    case 만반잘부
    case 윰차
    case 꾸안꾸
    case 실매
    case 삼귀자
    case 할많하않
}

