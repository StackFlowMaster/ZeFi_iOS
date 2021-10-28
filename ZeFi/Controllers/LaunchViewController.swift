//
//  LaunchViewController.swift
//  ZeFi
//
//  Created by Admin on 12/10/20.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblArabicTitle: UILabel!
    @IBOutlet weak var lblEnglishTitle: UILabel!
    @IBOutlet weak var btnArabic: UIButton!
    @IBOutlet weak var btnEnglish: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        
        let started = UserDefaults.standard.bool(forKey: "started")
        if started {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            navigationController?.pushViewController(vc, animated: false)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(gotoMain), name:NSNotification.Name(rawValue: "changed_language"), object: nil)
    }
    
    func configureView() {

        lblTitle.text = NSLocalizedString("app_name", comment: "")
        lblEnglishTitle.text = NSLocalizedString("please_choose_language2", comment: "")
        lblArabicTitle.text = NSLocalizedString("please_choose_language", comment: "")
        
        btnArabic.setTitle(NSLocalizedString("arabic", comment: ""), for: .normal)
        btnEnglish.setTitle(NSLocalizedString("english", comment: ""), for: .normal)
    }
    
    @IBAction func onArabic(_ sender: Any) {
        LanguageManager.shared.setLanguage(language: "ar")
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        UIButton.appearance().semanticContentAttribute = .forceRightToLeft
        UITextView.appearance().semanticContentAttribute = .forceRightToLeft
        UITextField.appearance().semanticContentAttribute = .forceRightToLeft
        UILabel.appearance().semanticContentAttribute = .forceRightToLeft
        DropDown.appearance().semanticContentAttribute = .forceRightToLeft
        gotoOnboarding()
    }
    
    @IBAction func onEnglish(_ sender: Any) {
        LanguageManager.shared.setLanguage(language: "en")
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        UIButton.appearance().semanticContentAttribute = .forceLeftToRight
        UITextView.appearance().semanticContentAttribute = .forceLeftToRight
        UITextField.appearance().semanticContentAttribute = .forceLeftToRight
        UILabel.appearance().semanticContentAttribute = .forceLeftToRight
        DropDown.appearance().semanticContentAttribute = .forceLeftToRight
        gotoOnboarding()
    }
    
    func gotoOnboarding() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
            self.navigationController?.pushViewController(vc, animated: false)
//        }
    }
    
    @objc func gotoMain() {
        navigationController?.popToRootViewController(animated: false)
        
        if LanguageManager.shared.currentLang == "ar" {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UIButton.appearance().semanticContentAttribute = .forceRightToLeft
            UITextView.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
            DropDown.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
            UITextView.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().semanticContentAttribute = .forceLeftToRight
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
            DropDown.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        navigationController?.pushViewController(vc, animated: false)
    }
}
