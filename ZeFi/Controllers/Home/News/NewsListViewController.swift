//
//  NewsListViewController.swift
//  ZeFi
//
//  Created by Admin on 12/12/20.
//

import UIKit

class NewsListViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var newsData: [String: Any]!
    var pages: [NewsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        initData()
    }
    
    func configureView() {
        lblTitle.text = (newsData["name"] as! String)
        
        topView.layer.cornerRadius = 20
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func initData() {
        let ps = newsData["pages"] as! [Any]
        for p in ps {
            let page = NewsModel(dict: p as! [String: Any])
            self.pages.append(page)
        }
        
        self.tableView.reloadData()
    }
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        let page = pages[indexPath.row]
        
        cell.lblContent.text = page.title
        cell.imgCover.sd_setImage(with: URL(string: page.cover), placeholderImage: UIImage(named: "picture_placeholder"))
        cell.lblTime.text = page.writer + " ● " +  Common.shared.convertDateString(inputDate: page.date)
        return cell
    }
}
