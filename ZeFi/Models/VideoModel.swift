//
//  VideoModel.swift
//  ZeFi
//
//  Created by Admin on 12/12/20.
//

import Foundation

class VideoModel: NSObject {
    
    var id = ""
    var title = ""
    var url = ""
    var isActive = false
    var photoUrl = ""
    var isMain = false
    var videoLeveId = ""

    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        if let val = dict["id"] as? String            { id = val }
        if let val = dict["title"] as? String         { title = val }
        if let val = dict["url"] as? String           { url = val }
        if let val = dict["isActive"] as? Bool        { isActive = val }
        if let val = dict["photoUrl"] as? String      { photoUrl = val }
        if let val = dict["isMain"] as? Bool          { isMain = val }
        if let val = dict["videoLeveId"] as? String   { videoLeveId = val }
    }
}
