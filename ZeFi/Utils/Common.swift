//
//  Common.swift
//  ZeFi
//
//  Created by Admin on 12/10/20.
//

import Foundation

enum HomeType: String {
    case news = "news"
    case zeCafe = "zeCafe"
    case zeAcademy = "zeAcademy"
    case zectionary = "zectionary"
    case digitalCurrenciesFromAToZ = "digitalCurrenciesFromAToZ"
    case electronicTrading = "electronicTrading"
    case videos = "videos"
    case team = "team"
}

class Common {
    static let shared = Common()
    private init() {
        print("NavManager Initialized")
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func convertDateString(inputDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        
        if let date = formatter.date(from: inputDate) {
            if LanguageManager.shared.currentLang == "ar" {
                formatter.locale = Locale(identifier: "ar_DZ")
                
                formatter.dateFormat = "MMMM yyyy dd"
                let outputDate = formatter.string(from: date)
                return outputDate
            } else {
                formatter.dateFormat = "dd MMM yy"
                let outputDate = formatter.string(from: date)
                return outputDate
            }
        } else {
            return ""
        }
    }
    
    func convertDoubleToGeneralString(value: Double) -> String {
        if value > 1000000000 {
            let str = String(format: "%.01fG", value / 1000000000)
            return str
        } else if value > 1000000 {
            let str = String(format: "%.01fM", value / 1000000)
            return str
        } else {
            return String(format: "%.2f", value)
        }
    }
    
    func getDefaultCoin() -> Int {
        let currency = UserDefaults.standard.integer(forKey: "currency")
        return currency
    }
    
    func getCoinUnit() -> String {
        
        let defaultCoin = getDefaultCoin()
        var unit = ""
        switch defaultCoin {
        case 0:
            unit = "$"
            break
        case 1:
            unit = "₿"
            break
        case 2:
            unit = "Ξ"
            break
        case 3:
            unit = "DOT"
            break
        case 4:
            unit = "BNB"
            break
        case 5:
            unit = "link"
            break
        case 6:
            unit = "SAR"
            break
        case 7:
            unit = "AED"
            break
        case 8:
            unit = "BHD"
            break
        case 9:
            unit = "KWD"
            break
        case 10:
            unit = "€"
            break
        default:
            unit = "$"
            break
        }
        return unit
    }
    
    func getCoinPrice(currency: CurrencyModel) -> Double {
        
        let defaultCoin = getDefaultCoin()
        var value = 0.0
        switch defaultCoin {
        case 0:
            value = currency.usd
            break
        case 1:
            value = currency.btc
            break
        case 2:
            value = currency.eth
            break
        case 3:
            value = currency.dot
            break
        case 4:
            value = currency.bnb
            break
        case 5:
            value = currency.link
            break
        case 6:
            value = currency.sar
            break
        case 7:
            value = currency.aed
            break
        case 8:
            value = currency.bhd
            break
        case 9:
            value = currency.kwd
            break
        case 10:
            value = currency.eur
            break
        default:
            value = currency.usd
            break
        }
        return value
    }
    
    func getCoinMarketCap(currency: CurrencyModel) -> Double {
        
        let defaultCoin = getDefaultCoin()
        var value = 0.0
        switch defaultCoin {
        case 0:
            value = currency.usdMarketCap
            break
        case 1:
            value = currency.btcMarketCap
            break
        case 2:
            value = currency.ethMarketCap
            break
        case 3:
            value = currency.dotMarketCap
            break
        case 4:
            value = currency.bnbMarketCap
            break
        case 5:
            value = currency.linkMarketCap
            break
        case 6:
            value = currency.sarMarketCap
            break
        case 7:
            value = currency.aedMarketCap
            break
        case 8:
            value = currency.bhdMarketCap
            break
        case 9:
            value = currency.kwdMarketCap
            break
        case 10:
            value = currency.eurMarketCap
            break
        default:
            value = currency.usdMarketCap
            break
        }
        return value
    }
    
    func getCoin24hVol(currency: CurrencyModel) -> Double {
        
        let defaultCoin = getDefaultCoin()
        var value = 0.0
        switch defaultCoin {
        case 0:
            value = currency.usd24hVol
            break
        case 1:
            value = currency.btc24hVol
            break
        case 2:
            value = currency.eth24hVol
            break
        case 3:
            value = currency.dot24hVol
            break
        case 4:
            value = currency.bnb24hVol
            break
        case 5:
            value = currency.link24hVol
            break
        case 6:
            value = currency.sar24hVol
            break
        case 7:
            value = currency.aed24hVol
            break
        case 8:
            value = currency.bhd24hVol
            break
        case 9:
            value = currency.kwd24hVol
            break
        case 10:
            value = currency.eur24hVol
            break
        default:
            value = currency.usd24hVol
            break
        }
        return value
    }
    
    func getCoin24hChange(currency: CurrencyModel) -> Double {
        
        let defaultCoin = getDefaultCoin()
        var value = 0.0
        switch defaultCoin {
        case 0:
            value = currency.usd24hChange
            break
        case 1:
            value = currency.btc24hChange
            break
        case 2:
            value = currency.eth24hChange
            break
        case 3:
            value = currency.dot24hChange
            break
        case 4:
            value = currency.bnb24hChange
            break
        case 5:
            value = currency.link24hChange
            break
        case 6:
            value = currency.sar24hChange
            break
        case 7:
            value = currency.aed24hChange
            break
        case 8:
            value = currency.bhd24hChange
            break
        case 9:
            value = currency.kwd24hChange
            break
        case 10:
            value = currency.eur24hChange
            break
        default:
            value = currency.usd24hChange
            break
        }
        return value
    }
}
