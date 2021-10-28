//
//  TeamViewController.swift
//  ZeFi
//
//  Created by Admin on 12/12/20.
//

import UIKit
import SafariServices

class TeamViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblBack: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var members: [TeamMember] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        getData()
    }
    
    func configureView() {
        topView.layer.cornerRadius = 20
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        tableView.estimatedRowHeight = 100
        
        if LanguageManager.shared.currentLang == "ar" {
            btnBack.setImage(UIImage(named: "ic_arrow_right"), for: .normal)
        } else {
            btnBack.setImage(UIImage(named: "ic_arrow_left"), for: .normal)
        }
        
        lblBack.text = NSLocalizedString("back", comment: "")
    }
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    func getData() {
        ProgressHUD.shared.show(view: view, msg: "")
        APIService.shared.getTeamMembers(completion: {
            error, res in
            
            ProgressHUD.shared.dismiss()
            
            if error != nil {
                self.showAlert(title: "", msg: error!.localizedDescription)
            } else {
                let response = res as! [String: Any]
                let members = response["teamMembers"] as! [Any]
                self.lblTitle.text = (response["title"] as! String)
                self.lblDesc.text = (response["description"] as! String)
                for mem in members {
                    let member = TeamMember(dict: mem as! [String: Any])
                    self.members.append(member)
                }
               
                self.tableView.reloadData()
            }
        })
    }
}

extension TeamViewController: UITableViewDelegate {
    
}

extension TeamViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberTableViewCell", for: indexPath) as! MemberTableViewCell
        let member = members[indexPath.row]
        
        cell.imgCover.sd_setImage(with: URL(string: member.cover), placeholderImage: UIImage(named: "picture_placeholder"))
        cell.lblName.text = member.name
        cell.lblPosition.text = member.position
        cell.lblDesc.text = member.desc
        
        cell.btnFacebook.isHidden = member.facebook.count == 0
        cell.btnLinkedIn.isHidden = member.linkedin.count == 0
        cell.btnTelegram.isHidden = member.telegram.count == 0
        cell.btnTwitter.isHidden = member.twitter.count == 0
        cell.btnYoutube.isHidden = member.youtube.count == 0
        cell.btnInstagram.isHidden = member.instagram.count == 0
        
        cell.btnFacebook.tag = indexPath.row
        cell.btnFacebook.addTarget(self, action: #selector(btnFacebookTapped(sender:)), for: .touchUpInside)
        
        cell.btnLinkedIn.tag = indexPath.row
        cell.btnLinkedIn.addTarget(self, action: #selector(btnLinkedinTapped(sender:)), for: .touchUpInside)
        
        cell.btnTelegram.tag = indexPath.row
        cell.btnTelegram.addTarget(self, action: #selector(btnTelegramTapped(sender:)), for: .touchUpInside)
        
        cell.btnTwitter.tag = indexPath.row
        cell.btnTwitter.addTarget(self, action: #selector(btnTwitterTapped(sender:)), for: .touchUpInside)
        
        cell.btnYoutube.tag = indexPath.row
        cell.btnYoutube.addTarget(self, action: #selector(btnYoutubeTapped(sender:)), for: .touchUpInside)
        
        cell.btnInstagram.tag = indexPath.row
        cell.btnInstagram.addTarget(self, action: #selector(btnInstagramTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func btnFacebookTapped(sender: UIButton) {
        let index = sender.tag
        let member = members[index]
        let vc = SFSafariViewController(url: URL(string: member.facebook)!)
        present(vc, animated: true, completion: nil)
    }
    
    @objc func btnLinkedinTapped(sender: UIButton) {
        let index = sender.tag
        let member = members[index]
        let vc = SFSafariViewController(url: URL(string: member.linkedin)!)
        present(vc, animated: true, completion: nil)
    }
    
    @objc func btnTelegramTapped(sender: UIButton) {
        let index = sender.tag
        let member = members[index]
        let vc = SFSafariViewController(url: URL(string: member.telegram)!)
        present(vc, animated: true, completion: nil)
    }
    
    @objc func btnTwitterTapped(sender: UIButton) {
        let index = sender.tag
        let member = members[index]
        let vc = SFSafariViewController(url: URL(string: member.twitter)!)
        present(vc, animated: true, completion: nil)
    }
    
    @objc func btnYoutubeTapped(sender: UIButton) {
        let index = sender.tag
        let member = members[index]
        let vc = SFSafariViewController(url: URL(string: member.youtube)!)
        present(vc, animated: true, completion: nil)
    }
    
    @objc func btnInstagramTapped(sender: UIButton) {
        let index = sender.tag
        let member = members[index]
        let vc = SFSafariViewController(url: URL(string: member.instagram)!)
        present(vc, animated: true, completion: nil)
    }
}


