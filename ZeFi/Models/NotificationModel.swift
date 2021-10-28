//
//  NotificationModel.swift
//  ZeFi
//
//  Created by Admin on 12/13/20.
//

import Foundation
class NotificationModel: NSObject {
    
    var id = ""
    var title = ""
    var body = ""
    var pageId = ""
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        if let val = dict["id"] as? String          { id = val }
        if let val = dict["title"] as? String       { title = val }
        if let val = dict["body"] as? String        { body = val }
        if let val = dict["pageId"] as? String      { pageId = val }
    }
}
