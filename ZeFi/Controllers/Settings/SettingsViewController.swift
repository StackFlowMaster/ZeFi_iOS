//
//  SettingsViewController.swift
//  ZeFi
//
//  Created by Admin on 12/11/20.
//

import UIKit
import PickerButton


class SettingsViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    @IBOutlet weak var btnCurrency: PickerButton!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var lblCurrencyTitle: UILabel!
    
    @IBOutlet weak var btnLang: PickerButton!
    @IBOutlet weak var lblLang: UILabel!
    @IBOutlet weak var lblLangTitle: UILabel!
    
    @IBOutlet weak var lblNotifications: UILabel!
    
    @IBOutlet weak var lblPrivacyTitle: UILabel!
    @IBOutlet weak var lblTermsTitle: UILabel!
    
    @IBOutlet weak var btnCoinArrow: UIButton!
    @IBOutlet weak var btnLangArrow: UIButton!
    @IBOutlet weak var btnPrivacyArrow: UIButton!
    @IBOutlet weak var btnTermsArrow: UIButton!
    
    var currencies = [NSLocalizedString("USD", comment: ""),
                      NSLocalizedString("btc", comment: ""),
                      NSLocalizedString("eth", comment: ""),
                      NSLocalizedString("dot", comment: ""),
                      NSLocalizedString("bnb", comment: ""),
                      NSLocalizedString("link", comment: ""),
                      NSLocalizedString("sar", comment: ""),
                      NSLocalizedString("aed", comment: ""),
                      NSLocalizedString("bhd", comment: ""),
                      NSLocalizedString("kwd", comment: ""),
                      NSLocalizedString("eur", comment: "")]
    
    var langs = ["اللغة العربية", "English"]
    
    let datasourceCurrency = CurrencyPickerDataSource()
    let datasourceLang = LangPickerDataSource()
    
    var isCurrency = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    

    func configureView() {
        if revealViewController() != nil {
//            btnMenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            if LanguageManager.shared.currentLang == "ar" {
                btnMenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), for: .touchUpInside)
                revealViewController()?.rearViewController = nil
                revealViewController()?.rightViewRevealWidth = UIScreen.main.bounds.width
                view.addGestureRecognizer(revealViewController().panGestureRecognizer())

            } else {
                revealViewController()?.rightViewController = nil
                revealViewController()?.rearViewRevealWidth = UIScreen.main.bounds.width
                view.addGestureRecognizer(revealViewController().panGestureRecognizer())
            }

        }
        
        topView.layer.cornerRadius = 20
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        firstView.layer.cornerRadius = 10
        secondView.layer.cornerRadius = 10
        thirdView.layer.cornerRadius = 10
        
        btnCurrency.delegate = datasourceCurrency
        btnCurrency.dataSource = datasourceCurrency
        datasourceCurrency.label = lblCurrency
        
        btnCurrency.closeButtonTitle = NSLocalizedString("done", comment: "")
        
        btnLang.delegate = datasourceLang
        btnLang.dataSource = datasourceLang
        datasourceLang.label = lblLang
        
        btnLang.closeButtonTitle = NSLocalizedString("done", comment: "")
        
        lblCurrency.text = currencies[Common.shared.getDefaultCoin()]
        if LanguageManager.shared.currentLang == "ar" {
            lblLang.text = langs[0]
            btnCoinArrow.setImage(UIImage(named: "ic_more"), for: .normal)
            btnLangArrow.setImage(UIImage(named: "ic_more"), for: .normal)
            btnPrivacyArrow.setImage(UIImage(named: "ic_more"), for: .normal)
            btnTermsArrow.setImage(UIImage(named: "ic_more"), for: .normal)
        } else {
            lblLang.text = langs[1]
            btnCoinArrow.setImage(UIImage(named: "ic_more_right"), for: .normal)
            btnLangArrow.setImage(UIImage(named: "ic_more_right"), for: .normal)
            btnPrivacyArrow.setImage(UIImage(named: "ic_more_right"), for: .normal)
            btnTermsArrow.setImage(UIImage(named: "ic_more_right"), for: .normal)
        }
        
        lblTitle.text = NSLocalizedString("settings", comment: "")
        lblCurrencyTitle.text = NSLocalizedString("default_coin", comment: "")
        lblLangTitle.text = NSLocalizedString("language", comment: "")
        lblNotifications.text = NSLocalizedString("notification", comment: "")
        lblPrivacyTitle.text = NSLocalizedString("privacy", comment: "")
        lblTermsTitle.text = NSLocalizedString("tearms_of_use", comment: "")
    }
    @IBAction func onCurrency(_ sender: Any) {
        isCurrency = true
    }
    
    @IBAction func onLanguage(_ sender: Any) {
        isCurrency = false
    }
    
    @IBAction func onPrivacy(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        vc.pageType = "3"
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func onTerms(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        vc.pageType = "2"
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func onQuestion(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        vc.pageType = "4"
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func onRate(_ sender: Any) {
    }
    
    @IBAction func onSearch(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        navigationController?.pushViewController(vc, animated: false)
    }
    
}

final class CurrencyPickerDataSource: NSObject, UIPickerViewDelegate, UIPickerViewDataSource, PickerButtonDelegate {
    
    var currencies = [NSLocalizedString("USD", comment: ""),
                      NSLocalizedString("btc", comment: ""),
                      NSLocalizedString("eth", comment: ""),
                      NSLocalizedString("dot", comment: ""),
                      NSLocalizedString("bnb", comment: ""),
                      NSLocalizedString("link", comment: ""),
                      NSLocalizedString("sar", comment: ""),
                      NSLocalizedString("aed", comment: ""),
                      NSLocalizedString("bhd", comment: ""),
                      NSLocalizedString("kwd", comment: ""),
                      NSLocalizedString("eur", comment: "")]
    var label: UILabel!
    var selectedIndex = 0
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedIndex = row
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerButtonDidClose(_ pickerButton: PickerButton) {
        let currency = currencies[selectedIndex]
        UserDefaults.standard.setValue(selectedIndex, forKey: "currency")
        label.text = currency
    }
}

final class LangPickerDataSource: NSObject, UIPickerViewDelegate, UIPickerViewDataSource, PickerButtonDelegate {
    
    var langs = ["اللغة العربية", "English"]
    var label: UILabel!
    var selectedIndex = 0
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        return langs[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return langs.count
    }
    
    func pickerButtonDidClose(_ pickerButton: PickerButton) {
        label.text = langs[selectedIndex]
        if selectedIndex == 0 { //Arabic
            LanguageManager.shared.setLanguage(language: "ar")
            NotificationCenter.default.post(name: Notification.Name(rawValue: "changed_language"), object: nil)
        } else { //English
            LanguageManager.shared.setLanguage(language: "en")
            NotificationCenter.default.post(name: Notification.Name(rawValue: "changed_language"), object: nil)
        }
    }
}


