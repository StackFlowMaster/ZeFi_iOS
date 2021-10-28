//
//  CurrencyDetailViewController.swift
//  ZeFi
//
//  Created by Admin on 12/12/20.
//

import UIKit
import WebKit

class CurrencyDetailViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblBack: UILabel!
    
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var chartView: WKWebView!
   
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblPriceTitle: UILabel!
    
    @IBOutlet weak var lblChange: UILabel!
    @IBOutlet weak var lblChangeTitle: UILabel!
    
    @IBOutlet weak var lblMarket: UILabel!
    @IBOutlet weak var lblMarketTitle: UILabel!
    
    @IBOutlet weak var lblTrading: UILabel!
    @IBOutlet weak var lblTradingTitle: UILabel!
    
    
    var currency: CurrencyModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.webView.scrollView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.webView.scrollView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if object is UIScrollView {
                if let newvalue = change?[.newKey] {
                    let newsize = newvalue as! CGSize
                    self.contentHeight.constant = newsize.height
                }
            }
        }
    }
    

    func configureView() {
        topView.layer.cornerRadius = 20
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        imgCover.sd_setImage(with: URL(string: currency.cover))
        imgLogo.sd_setImage(with: URL(string: currency.logo))
        lblTitle.text = currency.name
        let request = URLRequest(url: URL(string: "https://zefi.azurewebsites.net/ar/api/charts/draw/\(currency.id)")!)
        chartView.load(request)
        chartView.layer.borderWidth = 0.5
        chartView.layer.borderColor = UIColor.lightGray.cgColor
        
        infoView.layer.cornerRadius = 4
        
        var dir = ""
        if LanguageManager.shared.currentLang == "ar" {
            dir = "rtl"
        } else {
            dir = "ltr"
        }
        let htmlString = "<html dir=\(dir) lang=\(LanguageManager.shared.currentLang)><head><link rel='stylesheet' type='text/css' href='font.css'></head>\(currency.desc)</html>"
        
        
        self.webView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
        
        lblPrice.text = Common.shared.getCoinUnit() + String(format: " %.02f", Common.shared.getCoinPrice(currency: currency))
        lblChange.text = String(format: "%.02f", Common.shared.getCoin24hChange(currency: currency)) + "%"
        lblMarket.text = Common.shared.convertDoubleToGeneralString(value: Common.shared.getCoinMarketCap(currency: currency))
        
        lblTrading.text = Common.shared.convertDoubleToGeneralString(value: Common.shared.getCoin24hVol(currency: currency))
        
        if LanguageManager.shared.currentLang == "ar" {
            btnBack.setImage(UIImage(named: "ic_arrow_right"), for: .normal)
        } else {
            btnBack.setImage(UIImage(named: "ic_arrow_left"), for: .normal)
        }
        
        lblBack.text = NSLocalizedString("back", comment: "")
        
        lblPriceTitle.text = NSLocalizedString("price", comment: "")
        lblChangeTitle.text = NSLocalizedString("change_over_24", comment: "")
        lblMarketTitle.text = NSLocalizedString("market_cap", comment: "")
        lblTradingTitle.text = NSLocalizedString("trading24h", comment: "")

    }

    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
}
