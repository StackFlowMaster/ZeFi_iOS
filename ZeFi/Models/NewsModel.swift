//
//  NewsModel.swift
//  ZeFi
//
//  Created by Admin on 12/11/20.
//

import Foundation

class NewsModel: NSObject {
    
    var id = ""
    var categoryId = ""
    var categoryName = ""
    var cover = ""
    var writer = ""
    var title = ""
    var isChoose = false
    var readersCount = 0
    var date = ""
    var previousOrFutureDate = ""
    var personName = ""
    var isComment = false
    var pageLevel: [String: Any] = [:]
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        if let val = dict["id"] as? String                        { id = val }
        if let val = dict["categoryId"] as? String                { categoryId = val }
        if let val = dict["categoryName"] as? String              { categoryName = val }
        if let val = dict["cover"] as? String                     { cover = val }
        if let val = dict["writer"] as? String                    { writer = val }
        if let val = dict["title"] as? String                     { title = val }
        if let val = dict["isChoose"] as? Bool                    { isChoose = val }
        if let val = dict["readersCount"] as? Int                 { readersCount = val }
        if let val = dict["date"] as? String                      { date = val }
        if let val = dict["previousOrFutureDate"] as? String      { previousOrFutureDate = val }
        if let val = dict["personName"] as? String                { personName = val }
        if let val = dict["isComment"] as? Bool                   { isComment = val }
        if let val = dict["pageLevel"] as? [String: Any]                   { pageLevel = val }
    }
}
