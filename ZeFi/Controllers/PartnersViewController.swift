//
//  PartnersViewController.swift
//  ZeFi
//
//  Created by Admin on 12/12/20.
//

import UIKit
import SafariServices

class PartnersViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblBack: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var partners: [PartnerModel] = []
    
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
        lblTitle.text = NSLocalizedString("success_partners", comment: "")
    }
    
    func getData() {
        ProgressHUD.shared.show(view: view, msg: "")
        APIService.shared.getPartners(completion: {
            error, res in
            
            ProgressHUD.shared.dismiss()
            
            if error != nil {
                self.showAlert(title: "", msg: error!.localizedDescription)
            } else {
                let response = res as! [Any]
                for part in response {
                    let partner = PartnerModel(dict: part as! [String: Any])
                    self.partners.append(partner)
                }
                
                self.collectionView.reloadData()
            }
        })
    }
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
}

extension PartnersViewController: UICollectionViewDelegate {
    
}

extension PartnersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return partners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PartnerCollectionViewCell", for: indexPath) as! PartnerCollectionViewCell
        let partner = partners[indexPath.item]
        cell.imgCover.sd_setImage(with: URL(string: partner.cover), placeholderImage: UIImage(named: "picture_placeholder"))
        cell.lblName.text = partner.name
        
        cell.btnLink.tag = indexPath.row
        cell.btnLink.addTarget(self, action: #selector(btnLinkTapped(sender:)), for: .touchUpInside)
        
        cell.lblLink.text = NSLocalizedString("website_link", comment: "")
        return cell
    }
    
    @objc func btnLinkTapped(sender: UIButton) {
        let index = sender.tag
        let partner = partners[index]
        let vc = SFSafariViewController(url: URL(string: partner.websiteUrl)!)
        present(vc, animated: true, completion: nil)
    }
}

extension PartnersViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = collectionView.frame.width
        let height = width
        return CGSize(width: width, height: height)
    }
}
