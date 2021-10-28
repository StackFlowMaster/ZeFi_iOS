//
//  AcademyLevelViewController.swift
//  ZeFi
//
//  Created by Admin on 12/12/20.
//NSLocalizedString("back", comment: "")

import UIKit

class AcademyLevelViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblBack: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var academyData: [String: Any]!
    var levels: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        initData()
    }
    

    func configureView() {
        topView.layer.cornerRadius = 20
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        lblTitle.text = NSLocalizedString("academy", comment: "")
        
        if LanguageManager.shared.currentLang == "ar" {
            btnBack.setImage(UIImage(named: "ic_arrow_right"), for: .normal)
        } else {
            btnBack.setImage(UIImage(named: "ic_arrow_left"), for: .normal)
        }
        
        lblBack.text = NSLocalizedString("back", comment: "")
    }
    
    func initData() {
        let ls = academyData["levels"] as! [Any]
        
        for l in ls {
            let lev = l as! [String: Any]
            let lv = lev["level"] as! [String: Any]
            let level = lv["value"] as! String
            levels.append(level)
            print(level)
            tableView.reloadData()
        }
    }

    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
}

extension AcademyLevelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension AcademyLevelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcademyLevelTableViewCell", for: indexPath) as! AcademyLevelTableViewCell
        let level = levels[indexPath.row]
        
        print(level)
        switch indexPath.row {
        case 0:
            cell.lblTitle.text = NSLocalizedString("beginner", comment: "")//"مبتدئ"
            cell.lblSubTitle.text = NSLocalizedString("new_trader", comment: "")//"مدخل إلى التداول ال"
            cell.bkView.backgroundColor = UIColor(hexString: "#fff149")
            cell.topMargin.constant = 18
            break
        case 1:
            cell.lblTitle.text = NSLocalizedString("average", comment: "")//"متوسط"
            if LanguageManager.shared.currentLang == "ar" {
                cell.lblSubTitle.text = ""
                cell.topMargin.constant = 32
            } else {
                cell.lblSubTitle.text = NSLocalizedString("developer", comment: "")
                cell.topMargin.constant = 18
            }
            
            cell.bkView.backgroundColor = UIColor(hexString: "#f4be38")
            
            break
        case 2:
            cell.lblTitle.text = NSLocalizedString("advanced", comment: "")//"متقدّم"
            cell.lblSubTitle.text = NSLocalizedString("organizations", comment: "")//"تدريبات ومقالات خاصّة بالمتداولين والمطورين الراغبين بالاحتراف"
            cell.bkView.backgroundColor = UIColor(hexString: "#fff149")
            cell.topMargin.constant = 18
            break
        default:
            cell.lblTitle.text = ""
            cell.lblSubTitle.text = ""
            break
        }
        
        cell.btnCell.tag = indexPath.row
        cell.btnCell.addTarget(self, action: #selector(onLevelTapped(sender:)), for: .touchUpInside)
        if LanguageManager.shared.currentLang == "ar" {
            cell.imgArrow.image = UIImage(named: "ic_arrow_left")
        } else {
            cell.imgArrow.image = UIImage(named: "ic_arrow_right")
        }
        
        
        return cell
    }
    
    @objc func onLevelTapped(sender: UIButton) {
        let index = sender.tag
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PageListViewController") as! PageListViewController
        vc.mainCategory = "ZeAcademy"
        vc.pageLevel = "\(index + 1)"
        navigationController?.pushViewController(vc, animated: false)
    }
}
