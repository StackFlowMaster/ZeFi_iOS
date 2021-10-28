//
//  MenuRightViewController.swift
//  ZeFi
//
//  Created by Admin on 12/11/20.
//

import UIKit

class MenuRightViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    func configureView() {
        mainView.layer.cornerRadius = 30
        
        if LanguageManager.shared.currentLang == "ar" {
            mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        } else {
            mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
        
    }

}
