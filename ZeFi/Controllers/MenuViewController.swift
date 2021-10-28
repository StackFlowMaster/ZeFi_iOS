//
//  MenuViewController.swift
//  ZeFi
//
//  Created by Admin on 12/11/20.
//NSLocalizedString("app_name", comment: "")

import UIKit
import SafariServices

class MenuViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblDesc: UILabel!
    
    @IBOutlet weak var lblHome: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblNews: UILabel!
    @IBOutlet weak var lblAcademy: UILabel!
    @IBOutlet weak var lblDictionary: UILabel!
    @IBOutlet weak var lblTeam: UILabel!
    @IBOutlet weak var lblPartner: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    
    
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
        
        if LanguageManager.shared.currentLang == "ar" {
            lblDesc.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        } else {
            lblDesc.transform = CGAffineTransform(rotationAngle: .pi / 2)
        }
        
        
        lblDesc.text = NSLocalizedString("follow_us_on_social_network", comment: "")
        lblHome.text = NSLocalizedString("home", comment: "")
        lblInfo.text = NSLocalizedString("how_are", comment: "")
        lblNews.text = NSLocalizedString("news", comment: "")
        lblAcademy.text = NSLocalizedString("academy", comment: "")
        lblDictionary.text = NSLocalizedString("dictionary", comment: "")
        lblTeam.text = NSLocalizedString("zefi_team", comment: "")
        lblPartner.text = NSLocalizedString("partners", comment: "")
        lblContact.text = NSLocalizedString("connect_us", comment: "")
        
    }
    
    @IBAction func onMenu(_ sender: Any) {
        revealViewController().revealToggle(nil)
    }
    
    //Menu Item Action
    
    @IBAction func onHome(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open_home"), object: nil)
        revealViewController().revealToggle(nil)
    }
    
    @IBAction func onHowWeAre(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open_how"), object: nil)
        revealViewController().revealToggle(nil)
    }
    
    @IBAction func onNews(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open_news"), object: nil)
        revealViewController().revealToggle(nil)
    }
    
    @IBAction func onAcademy(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open_academy"), object: nil)
        revealViewController().revealToggle(nil)
    }
    
    @IBAction func onDictionary(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open_dictionary"), object: nil)
        revealViewController().revealToggle(nil)
    }
    
    @IBAction func onTeam(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open_team"), object: nil)
        revealViewController().revealToggle(nil)
    }
    
    @IBAction func onPartner(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open_partner"), object: nil)
        revealViewController().revealToggle(nil)
    }
    
    @IBAction func onContact(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open_contact"), object: nil)
        revealViewController().revealToggle(nil)
    }
    
    //Social Item Action
    
    @IBAction func onFacebook(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://www.facebook.com/Zendetta.Fi/")!)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onTwitter(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://twitter.com/ZendettaFi/")!)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onInstagram(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://www.instagram.com/ZendettaFi/")!)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onLinkedIn(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://www.linkedin.com/company/ze-fi/")!)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onYoutube(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://www.youtube.com/channel/UCgFuVCObndXESpCcq56baAQ")!)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onTelegram(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://t.me/ZendettaFi/")!)
        present(vc, animated: true, completion: nil)
    }
}
