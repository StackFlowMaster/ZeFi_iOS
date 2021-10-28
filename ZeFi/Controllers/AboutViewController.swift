//
//  AboutViewController.swift
//  ZeFi
//
//  Created by Admin on 12/13/20.
//NSLocalizedString("app_name", comment: "")

import UIKit
import WebKit

class AboutViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblBack: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    
    var pageType = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        getData()
    }
    
    func configureView() {
        topView.layer.cornerRadius = 20
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        if LanguageManager.shared.currentLang == "ar" {
            btnBack.setImage(UIImage(named: "ic_arrow_right"), for: .normal)
        } else {
            btnBack.setImage(UIImage(named: "ic_arrow_left"), for: .normal)
        }
        
        lblBack.text = NSLocalizedString("back", comment: "")
    }
    
    func getData() {
        ProgressHUD.shared.show(view: view, msg: "")
        APIService.shared.getStaticPages(pageType: pageType, completion: {
            error, res in
            ProgressHUD.shared.dismiss()
            if error != nil {
                self.showAlert(title: "", msg: error!.localizedDescription)
            } else {
                let response = res as! [String: Any]
                let content = response["content"] as! String
                let pageType = response["pageType"] as! [String: Any]
                self.lblTitle.text = (pageType["value"] as! String)
                
                var dir = ""
                if LanguageManager.shared.currentLang == "ar" {
                    dir = "rtl"
                } else {
                    dir = "ltr"
                }
                let htmlString = "<html dir=\(dir) lang=\(LanguageManager.shared.currentLang)><head><link rel='stylesheet' type='text/css' href='font.css'></head>\(content)</html>"
                
                self.webView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
            }
        })
    }
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
}
