//
//  PageDetailViewController.swift
//  ZeFi
//
//  Created by Admin on 12/13/20.
//

import UIKit
import WebKit
class PageDetailViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblBack: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblViewCnt: UILabel!
    
    var id: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        getPageDetail()
    }
    
    func configureView() {
        lblName.text = ""
        lblInfo.text = ""
        lblViewCnt.text = ""
        
        topView.layer.cornerRadius = 20
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        if LanguageManager.shared.currentLang == "ar" {
            btnBack.setImage(UIImage(named: "ic_arrow_right"), for: .normal)
        } else {
            btnBack.setImage(UIImage(named: "ic_arrow_left"), for: .normal)
        }
        
        lblBack.text = NSLocalizedString("back", comment: "")
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
    
    func getPageDetail() {
        ProgressHUD.shared.show(view: view, msg: "")
        APIService.shared.getPageDetail(id: id, uuid: id, completion: {
            error, res in
            ProgressHUD.shared.dismiss()
            if error != nil {
                self.showAlert(title: "", msg: error!.localizedDescription)
            } else {
                let response = res as! [String: Any]
                let title = response["title"] as! String
                self.lblName.text = title
                let content = response["content"] as! String
                var dir = ""
                if LanguageManager.shared.currentLang == "ar" {
                    dir = "rtl"
                } else {
                    dir = "ltr"
                }
                let htmlString = "<html dir=\(dir) lang=\(LanguageManager.shared.currentLang)><head><link rel='stylesheet' type='text/css' href='font.css'></head>\(content)</html>"
                
                self.webView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
                let photo = response["cover"] as! String
                self.imgCover.sd_setImage(with: URL(string: photo), placeholderImage: UIImage(named: "picture_placeholder"))
                let category = response["categoryName"] as! String
                let date = response["date"] as! String
                let dateStr = Common.shared.convertDateString(inputDate: date)
                let views = response["readersCount"] as! Int
                
                self.lblInfo.text = category + " ● " + dateStr + " ● "
                self.lblViewCnt.text = "\(views)"
            }
        })
    }

    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func onShare(_ sender: Any) {
        let url = "https://www.ze.fi/pages/\(id)"
        let txtToShare = [url]
        let vc = UIActivityViewController(activityItems: txtToShare, applicationActivities: nil)
        vc.popoverPresentationController?.sourceView = self.view
        present(vc, animated: true, completion: nil)
    }
}


