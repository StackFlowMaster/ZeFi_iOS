//
//  NotificationViewController.swift
//  ZeFi
//
//  Created by Admin on 12/11/20.
//
//NSLocalizedString("more", comment: "")

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var notifications: [NotificationModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        
        getData()
    }
    
    func configureView() {
        if revealViewController() != nil {
//
            if LanguageManager.shared.currentLang == "ar" {
                btnMenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), for: .touchUpInside)
                revealViewController()?.rearViewController = nil
                revealViewController()?.rightViewRevealWidth = UIScreen.main.bounds.width
                view.addGestureRecognizer(revealViewController().panGestureRecognizer())

            } else {
                btnMenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
                revealViewController()?.rightViewController = nil
                revealViewController()?.rearViewRevealWidth = UIScreen.main.bounds.width
                view.addGestureRecognizer(revealViewController().panGestureRecognizer())
            }

        }
        
        tableView.estimatedRowHeight = 100
        
        topView.layer.cornerRadius = 20
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        lblTitle.text = NSLocalizedString("notification", comment: "")
//        lblSubTitle.text = NSLocalizedString("notification", comment: "")
    }
    
    func getData() {
        ProgressHUD.shared.show(view: view, msg: "")
        APIService.shared.getNotifications(pageNum: 1, size: 100, completion: {
            error, res in
            ProgressHUD.shared.dismiss()
            
            if error != nil {
                self.showAlert(title: "", msg: error!.localizedDescription)
            } else {
                let response = res as! [String: Any]
                let list = response["list"] as! [Any]
                for ls in list {
                    let notification = NotificationModel(dict: ls as! [String: Any])
                    self.notifications.append(notification)
                }
                
                self.tableView.reloadData()
            }
        })
    }
    
    @IBAction func onSearch(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension NotificationViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 112
//    }
}

extension NotificationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        let notification = notifications[indexPath.row]
        
        cell.lblTitle.text = notification.title
        cell.lblTime.text = notification.body
        return cell
    }
    
    
}
