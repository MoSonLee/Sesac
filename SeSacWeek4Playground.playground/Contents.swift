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
        willSet {
            print("USD willSet - 환전 금액: USD \(KRW / currencyRate)")
        }
        didSet {
            print("USD didSet - KRW: \(KRW)원 -> \(USD)")
        }
    }
    
    var KRW: Double {
        get {
            return currencyRate * USD
        }
        set {
            USD = newValue / currencyRate
        }
    }
}

var rate = ExchangeRate(currencyRate: 1100, USD: 0)

rate.KRW = 500000
rate.currencyRate = 1350
rate.KRW = 500000
