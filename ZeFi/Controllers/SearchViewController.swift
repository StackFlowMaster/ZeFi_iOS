//
//  SearchViewController.swift
//  ZeFi
//
//  Created by Admin on 12/14/20.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblBack: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var noFoundView: UIView!
    @IBOutlet weak var lblSorry: UILabel!
    @IBOutlet weak var lblNoData: UILabel!
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblSearchResult: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    
    var pages: [NewsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
        
    func configureView() {
        tableView.isHidden = true
        txtSearch.delegate = self
        
        if LanguageManager.shared.currentLang == "ar" {
            btnBack.setImage(UIImage(named: "ic_arrow_right"), for: .normal)
        } else {
            btnBack.setImage(UIImage(named: "ic_arrow_left"), for: .normal)
        }
        
        lblBack.text = NSLocalizedString("back", comment: "")
        lblTitle.text = NSLocalizedString("search", comment: "")
        
        txtSearch.placeholder = NSLocalizedString("enter_text", comment: "")
        
        lblSorry.text = NSLocalizedString("sorry", comment: "")
        lblNoData.text = NSLocalizedString("no_data_found", comment: "")
        lblSearchResult.text = NSLocalizedString("search_result", comment: "")
    }

    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    func searchPages(key: String) {
        ProgressHUD.shared.show(view: view, msg: "")
        APIService.shared.searchPages(key: key, completion: {
            error, res in
            
            ProgressHUD.shared.dismiss()
            if error != nil {
                self.showAlert(title: "", msg: error!.localizedDescription)
            } else {
                let response = res as! [String: Any]
                let pages = response["pages"] as! [String: Any]
                let count = pages["totalItems"] as! Int
                if count == 0 {
                    self.tableView.isHidden = true
                } else {
                    self.tableView.isHidden = false
                }
                
                self.lblResult.text = String(format: "\(NSLocalizedString("we_found", comment: "")) %d \(NSLocalizedString("result", comment: ""))", count)
                
                let list = pages["list"] as! [Any]
                for ls in list {
                    let page = NewsModel(dict: ls as! [String: Any])
                    self.pages.append(page)
                }
                
                self.tableView.reloadData()
            }
        })
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        let page = pages[indexPath.row]
        cell.imgCover.sd_setImage(with: URL(string: page.cover), placeholderImage: UIImage(named: "picture_placeholder"))
        cell.lblTitle.text = page.title
        cell.btnCell.tag = indexPath.row
        cell.btnCell.addTarget(self, action: #selector(onPageTapped(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func onPageTapped(sender: UIButton) {
        let index = sender.tag
        let new = pages[index]
        let vc = storyboard?.instantiateViewController(withIdentifier: "PageDetailViewController") as! PageDetailViewController
        vc.id = new.id
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let key = txtSearch.text ?? ""
        if key.count > 0 {
            searchPages(key: key)
        }
        
        return true
    }
}
