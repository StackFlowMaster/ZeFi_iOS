//
//  TeamModel.swift
//  ZeFi
//
//  Created by Admin on 12/12/20.
//

import Foundation


class TeamMember: NSObject {
    
    var id = ""
    var cover = ""
    var name = ""
    var desc = ""
    var position = ""
    var facebook = ""
    var linkedin = ""
    var telegram = ""
    var twitter = ""
    var youtube = ""
    var instagram = ""
    var medium = ""

    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        if let val = dict["id"] as? String            { id = val }
        if let val = dict["cover"] as? String         { cover = val }
        if let val = dict["description"] as? String   { desc = val }
        if let val = dict["position"] as? String      { position = val }
        if let val = dict["facebook"] as? String      { facebook = val }
        if let val = dict["linkedin"] as? String      { linkedin = val }
        if let val = dict["telegram"] as? String      { telegram = val }
        if let val = dict["twitter"] as? String       { twitter = val }
        if let val = dict["youtube"] as? String       { youtube = val }
        if let val = dict["instagram"] as? String     { instagram = val }
        if let val = dict["medium"] as? String        { medium = val }
        if let val = dict["name"] as? String          { name = val }
    }
}
