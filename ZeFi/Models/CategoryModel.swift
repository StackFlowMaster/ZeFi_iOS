//
//  CategoryModel.swift
//  ZeFi
//
//  Created by Admin on 12/12/20.
//

import Foundation
class CategoryModel: NSObject {
    
    var id = ""
    var mainCategoryId = ""
    var name = ""
    var desc = ""
    var pages: [NewsModel] = []
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        if let val = dict["id"] as? String                        { id = val }
        if let val = dict["mainCategoryId"] as? String            { mainCategoryId = val }
        if let val = dict["name"] as? String                      { name = val }
        if let val = dict["description"] as? String               { desc = val }
        if let val = dict["pages"] as? [Any] {
            for v in val {
                let page = NewsModel(dict: v as! [String: Any])
                pages.append(page)
            }
        }
    }
}
