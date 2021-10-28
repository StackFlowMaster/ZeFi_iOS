//
//  MainViewController.swift
//  ZeFi
//
//  Created by Admin on 12/11/20.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tabView: UIView!
    
    @IBOutlet weak var homeBanner: UIView!
    @IBOutlet weak var imgHome: UIImageView!
    @IBOutlet weak var lblHome: UILabel!
    
    @IBOutlet weak var coffeeBanner: UIView!
    @IBOutlet weak var imgCoffee: UIImageView!
    @IBOutlet weak var lblCoffee: UILabel!
    
    @IBOutlet weak var notificationBanner: UIView!
    @IBOutlet weak var imgNotification: UIImageView!
    @IBOutlet weak var lblNotification: UILabel!
    
    @IBOutlet weak var settingsBanner: UIView!
    @IBOutlet weak var imgSettings: UIImageView!
    @IBOutlet weak var lblSettings: UILabel!
    
    var curVC: UIViewController?
    
    var curIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(openHome), name:NSNotification.Name(rawValue: "open_home"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(openCafe), name:NSNotification.Name(rawValue: "open_cafe"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openHow), name:NSNotification.Name(rawValue: "open_how"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openNews), name:NSNotification.Name(rawValue: "open_news"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openAcademy), name:NSNotification.Name(rawValue: "open_academy"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openDictionary), name:NSNotification.Name(rawValue: "open_dictionary"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openTeamPage), name:NSNotification.Name(rawValue: "open_team"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openPartnerPage), name:NSNotification.Name(rawValue: "open_partner"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openContactPage), name:NSNotification.Name(rawValue: "open_contact"), object: nil)
        
    }
    

    func configureView() {
        
        tabView.layer.cornerRadius = 16
        tabView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        changeTabPage(nextIndex: 0, vc: vc)

        lblHome.text = NSLocalizedString("home", comment: "")
        lblCoffee.text = NSLocalizedString("ze_cafe", comment: "")
        lblNotification.text = NSLocalizedString("notification", comment: "")
        lblSettings.text = NSLocalizedString("settings", comment: "")
    }

    @IBAction func onHome(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        changeTabPage(nextIndex: 0, vc: vc)
    }
    
    @IBAction func onCoffee(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CoffeeViewController") as! CoffeeViewController
        changeTabPage(nextIndex: 1, vc: vc)
    }
    
    @IBAction func onNotification(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        changeTabPage(nextIndex: 2, vc: vc)
    }
    
    @IBAction func onSettings(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        changeTabPage(nextIndex: 3, vc: vc)
    }
    
    func changeTabPage(nextIndex: Int, vc: UIViewController) {
        if nextIndex == curIndex {
            return
        }
        
        curIndex = nextIndex
        changeTabBar(index: nextIndex)
        
        addChild(vc)
        vc.view.frame = mainView.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.didMove(toParent: self)
        mainView.addSubview(vc.view)
        
        curVC = vc
    }
    
    func changeTabBar(index: Int) {
        
        homeBanner.isHidden = true
        imgHome.alpha = 0.5
        lblHome.alpha = 0.5
        
        coffeeBanner.isHidden = true
        imgCoffee.alpha = 0.5
        lblCoffee.alpha = 0.5
        
        notificationBanner.isHidden = true
        imgNotification.alpha = 0.5
        lblNotification.alpha = 0.5
        
        settingsBanner.isHidden = true
        imgSettings.alpha = 0.5
        lblSettings.alpha = 0.5
        
        switch index {
        case 0:
            homeBanner.isHidden = false
            imgHome.alpha = 1
            lblHome.alpha = 1
            break
        case 1:
            coffeeBanner.isHidden = false
            imgCoffee.alpha = 1
            lblCoffee.alpha = 1
            break
        case 2:
            notificationBanner.isHidden = false
            imgNotification.alpha = 1
            lblNotification.alpha = 1
            break
        case 3:
            settingsBanner.isHidden = false
            imgSettings.alpha = 1
            lblSettings.alpha = 1
            break
        default:
            break
        }
    }
    
    @objc func openHome() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        changeTabPage(nextIndex: 0, vc: vc)
    }
    
    @objc func openCafe() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CoffeeViewController") as! CoffeeViewController
        changeTabPage(nextIndex: 1, vc: vc)
    }
    
    @objc func openHow() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func openNews() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PageListViewController") as! PageListViewController
        vc.mainCategory = "News"
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func openAcademy() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PageListViewController") as! PageListViewController
        vc.mainCategory = "ZeAcademy"
//        vc.pageLevel = "1"
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func openDictionary() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PageListViewController") as! PageListViewController
        vc.mainCategory = "Zectionary"
//        vc.pageLevel = "1"
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func openTeamPage() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TeamViewController") as! TeamViewController
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func openPartnerPage() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PartnersViewController") as! PartnersViewController
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func openContactPage() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
        navigationController?.pushViewController(vc, animated: false)
    }
}
