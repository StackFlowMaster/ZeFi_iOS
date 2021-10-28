//
//  LangManager.swift
//  ZeFi
//
//  Created by Admin on 12/10/20.
//

import Foundation
import UIKit

var AssociatedObjectHandle: UInt8 = 0

class LanguageManager: Bundle {

    static let shared:LanguageManager = {
        object_setClass(Bundle.main, LanguageManager.self)
        return LanguageManager()
    }()
    
    // save/get seleccted language
    var currentLang:String{
        get{
            return UserDefaults.standard.string(forKey: "selectedLanguage") ?? NSLocale.preferredLanguages[0]
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "selectedLanguage")
        }
    }
    
    // overide localized string function
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = objc_getAssociatedObject(self, &AssociatedObjectHandle) as? Bundle{
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        }else{
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
    
    func setLanguage(language:String){
        // change current bundle path from main to selected language
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let value = Bundle(path: path!)
        objc_setAssociatedObject(Bundle.main, &AssociatedObjectHandle, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        // change app language
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        // set current language
        currentLang = language
    }
}
