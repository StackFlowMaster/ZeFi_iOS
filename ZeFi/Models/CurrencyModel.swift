//
//  CurrencyModel.swift
//  ZeFi
//
//  Created by Admin on 12/11/20.
//

import Foundation

class CurrencyModel: NSObject {
    
    var id = ""
    var name = ""
    var desc = ""
    var symbol = ""
    var usd = 0.0
    var usdMarketCap = 0.0
    var usd24hVol = 0.0
    var usd24hChange = 0.0
    var btc = 0.0
    var btcMarketCap = 0.0
    var btc24hVol = 0.0
    var btc24hChange = 0.0
    var eth = 0.0
    var ethMarketCap = 0.0
    var eth24hVol = 0.0
    var eth24hChange = 0.0
    var dot = 0.0
    var dotMarketCap = 0.0
    var dot24hVol = 0.0
    var dot24hChange = 0.0
    var bnb = 0.0
    var bnbMarketCap = 0.0
    var bnb24hVol = 0.0
    var bnb24hChange = 0.0
    var link = 0.0
    var linkMarketCap = 0.0
    var link24hVol = 0.0
    var link24hChange = 0.0
    var sar = 0.0
    var sarMarketCap = 0.0
    var sar24hVol = 0.0
    var sar24hChange = 0.0
    var aed = 0.0
    var aedMarketCap = 0.0
    var aed24hVol = 0.0
    var aed24hChange = 0.0
    var bhd = 0.0
    var bhdMarketCap = 0.0
    var bhd24hVol = 0.0
    var bhd24hChange = 0.0
    var kwd = 0.0
    var kwdMarketCap = 0.0
    var kwd24hVol = 0.0
    var kwd24hChange = 0.0
    var eur = 0.0
    var eurMarketCap = 0.0
    var eur24hVol = 0.0
    var eur24hChange = 0.0
    
    var lastChangeImage = ""
    var cover = ""
    var logo = ""
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        if let val = dict["id"] as? String                { id = val }
        if let val = dict["name"] as? String              { name = val }
        if let val = dict["description"] as? String       { desc = val }
        if let val = dict["symbol"] as? String            { symbol = val }
        if let val = dict["usd"] as? Double               { usd = val }
        if let val = dict["usdMarketCap"] as? Double      { usdMarketCap = val }
        if let val = dict["usd24hVol"] as? Double         { usd24hVol = val }
        if let val = dict["usd24hChange"] as? Double      { usd24hChange = val }
        if let val = dict["btc"] as? Double               { btc = val }
        if let val = dict["btcMarketCap"] as? Double      { btcMarketCap = val }
        if let val = dict["btc24hVol"] as? Double         { btc24hVol = val }
        if let val = dict["btc24hChange"] as? Double      { btc24hChange = val }
        if let val = dict["eth"] as? Double               { eth = val }
        if let val = dict["ethMarketCap"] as? Double      { ethMarketCap = val }
        if let val = dict["eth24hVol"] as? Double         { eth24hVol = val }
        if let val = dict["eth24hChange"] as? Double      { eth24hChange = val }
        if let val = dict["dot"] as? Double               { dot = val }
        if let val = dict["dotMarketCap"] as? Double      { dotMarketCap = val }
        if let val = dict["dot24hVol"] as? Double         { dot24hVol = val }
        if let val = dict["dot24hChange"] as? Double      { dot24hChange = val }
        if let val = dict["bnb"] as? Double               { bnb = val }
        if let val = dict["bnbMarketCap"] as? Double      { bnbMarketCap = val }
        if let val = dict["bnb24hVol"] as? Double         { bnb24hVol = val }
        if let val = dict["bnb24hChange"] as? Double      { bnb24hChange = val }
        if let val = dict["link"] as? Double              { link = val }
        if let val = dict["linkMarketCap"] as? Double     { linkMarketCap = val }
        if let val = dict["link24hVol"] as? Double        { link24hVol = val }
        if let val = dict["link24hChange"] as? Double     { link24hChange = val }
        if let val = dict["sar"] as? Double               { sar = val }
        if let val = dict["sarMarketCap"] as? Double      { sarMarketCap = val }
        if let val = dict["sar24hVol"] as? Double         { sar24hVol = val }
        if let val = dict["sar24hChange"] as? Double      { sar24hChange = val }
        if let val = dict["aed"] as? Double               { aed = val }
        if let val = dict["aedMarketCap"] as? Double      { aedMarketCap = val }
        if let val = dict["aed24hVol"] as? Double         { aed24hVol = val }
        if let val = dict["aed24hChange"] as? Double      { aed24hChange = val }
        if let val = dict["bhd"] as? Double               { bhd = val }
        if let val = dict["bhdMarketCap"] as? Double      { bhdMarketCap = val }
        if let val = dict["bhd24hVol"] as? Double         { bhd24hVol = val }
        if let val = dict["bhd24hChange"] as? Double      { bhd24hChange = val }
        if let val = dict["kwd"] as? Double               { kwd = val }
        if let val = dict["kwdMarketCap"] as? Double      { kwdMarketCap = val }
        if let val = dict["kwd24hVol"] as? Double         { kwd24hVol = val }
        if let val = dict["kwd24hChange"] as? Double      { kwd24hChange = val }
        if let val = dict["eur"] as? Double               { eur = val }
        if let val = dict["eurMarketCap"] as? Double      { eurMarketCap = val }
        if let val = dict["eur24hVol"] as? Double         { eur24hVol = val }
        if let val = dict["eur24hChange"] as? Double      { eur24hChange = val }
        
        if let val = dict["lastChangeImage"] as? String   { lastChangeImage = val }
        if let val = dict["cover"] as? String             { cover = val }
        if let val = dict["logo"] as? String              { logo = val }
    }
}
