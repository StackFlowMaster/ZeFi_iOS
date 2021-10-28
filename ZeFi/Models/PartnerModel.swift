//
//  PartnerModel.swift
//  ZeFi
//
//  Created by Admin on 12/12/20.
//



import Foundation
class PartnerModel: NSObject {
    
    var id = ""
    var name = ""
    var cover = ""
    var websiteUrl = ""
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        if let val = dict["id"] as? String              { id = val }
        if let val = dict["name"] as? String            { name = val }
        if let val = dict["cover"] as? String           { cover = val }
        if let val = dict["websiteUrl"] as? String      { websiteUrl = val }
    }
}
