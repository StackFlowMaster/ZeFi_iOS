//
//  ProgressHUD.swift
//  ZeFi
//
//  Created by Admin on 12/10/20.
//

import Foundation
import JGProgressHUD
import UIKit

class ProgressHUD {
    static let shared = ProgressHUD()
    let hud = JGProgressHUD(style: .light)
    
    private init() {}
    
    func show(view: UIView, msg: String) {
        hud.textLabel.text = msg
        hud.show(in: view)
    }
    
    func dismiss() {
        //hud.dismiss(afterDelay: 3.0)
        hud.dismiss()
    }
    
}
