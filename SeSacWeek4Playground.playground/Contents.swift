import UIKit

struct ExchangeRate {
    
    var currencyRate: Double {
        willSet {
            print("willSet: 환율이 \(currencyRate)에서 \(newValue)로 변경될 예정입니다..")
        }
        didSet {
            print("didSet: 환율이 \(oldValue)에서 \(currencyRate)로 변경되었습니다...")
        }
    }
    
    var USD: Double {
        get {
            print("현재 ")
            return KRW / currencyRate
        }
        set {
            currencyRate = newValue
        }
    }
    
    var KRW: Double {
        get {
            print("원화로는 \(currencyRate * USD)입니다.")
            return currencyRate * USD
        }
        set {
            print(newValue)
        }
    }
}

var rate = ExchangeRate(currencyRate: 1000)
rate.KRW = 5000
rate.USD = 1000
