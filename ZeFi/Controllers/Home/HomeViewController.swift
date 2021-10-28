//
//  HomeViewController.swift
//  ZeFi
//
//  Created by Admin on 12/11/20.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblAll: UILabel!
    @IBOutlet weak var currencyBlurView: UIView!
    @IBOutlet weak var currencyCollectionView: UICollectionView!
    
    @IBOutlet weak var newsConView: UIView!
    @IBOutlet weak var lblNewsTitle: UILabel!
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var newsHeight: NSLayoutConstraint!
    @IBOutlet weak var btnNewsMore: UIButton!
    @IBOutlet weak var lblNewsMore: UILabel!
    
    @IBOutlet weak var academyConView: UIView!
    @IBOutlet weak var lblAcademyTitle: UILabel!
    @IBOutlet weak var btnAcademy: UIButton!
    
    @IBOutlet weak var coffeeConView: UIView!
    @IBOutlet weak var lblCoffeeTitle: UILabel!
    @IBOutlet weak var coffeeCollectionView: UICollectionView!
    @IBOutlet weak var btnCafeMore: UIButton!
    
    @IBOutlet weak var discussConView: UIView!
    @IBOutlet weak var discussTitle: UILabel!
    @IBOutlet weak var discussCollectionView: UICollectionView!
    
    @IBOutlet weak var zectConView: UIView!
    @IBOutlet weak var lblzectTitle: UILabel!
    @IBOutlet weak var zectCollectionView: UICollectionView!
    @IBOutlet weak var btnZectMore: UIButton!
    
    @IBOutlet weak var electronicConView: UIView!
    @IBOutlet weak var lblElectronicTitle: UILabel!
    @IBOutlet weak var electronicCollectionView: UICollectionView!
    
    @IBOutlet weak var videoConView: UIView!
    @IBOutlet weak var lblVideoTitle: UILabel!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    
    @IBOutlet weak var teamConView: UIView!
    @IBOutlet weak var lblTeamTitle: UILabel!
    @IBOutlet weak var teamCollectionView: UICollectionView!
    
    @IBOutlet weak var academyColConView: UIView!
    @IBOutlet weak var lblAcademyColTitle: UILabel!
    @IBOutlet weak var academyCollectionView: UICollectionView!
    @IBOutlet weak var btnAcademyColMore: UIButton!
    
    var currencies: [CurrencyModel] = []
    
    var news: [NewsModel] = []
    var coffees: [NewsModel] = []
    var discusses: [NewsModel] = []
    var zectionaries: [NewsModel] = []
    var electronics: [NewsModel] = []
    var videos: [VideoModel] = []
    var members: [TeamMember] = []
    
    var academies: [NewsModel] = []
    
    var responseData: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        getHomeData()
        getCurrencies()
    }
    
    func configureView() {
        
        if revealViewController() != nil {

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
        
        lblTitle.text = NSLocalizedString("home", comment: "")
        lblNewsTitle.text = NSLocalizedString("news", comment: "")
        lblAcademyTitle.text = NSLocalizedString("academy", comment: "")
        lblCoffeeTitle.text = NSLocalizedString("ze_cafe", comment: "")
        lblzectTitle.text = NSLocalizedString("dictionary", comment: "")
        lblAcademyColTitle.text = NSLocalizedString("academy", comment: "")
        
        topView.layer.cornerRadius = 20
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = currencyBlurView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        currencyBlurView.addSubview(blurEffectView)
        
        if LanguageManager.shared.currentLang == "ar" {
            btnNewsMore.setImage(UIImage(named: "ic_arrow_left"), for: .normal)
            btnCafeMore.setImage(UIImage(named: "ic_arrow_left"), for: .normal)
            btnAcademyColMore.setImage(UIImage(named: "ic_arrow_left_white"), for: .normal)
            btnZectMore.setImage(UIImage(named: "ic_arrow_left"), for: .normal)
            btnAcademy.setBackgroundImage(UIImage(named: "academy_bk"), for: .normal)
        } else {
            btnNewsMore.setImage(UIImage(named: "ic_arrow_right"), for: .normal)
            btnCafeMore.setImage(UIImage(named: "ic_arrow_right"), for: .normal)
            btnAcademyColMore.setImage(UIImage(named: "ic_arrow_right_white"), for: .normal)
            btnZectMore.setImage(UIImage(named: "ic_arrow_right"), for: .normal)
            btnAcademy.setBackgroundImage(UIImage(named: "academy_bk_en"), for: .normal)
        }
        
        lblNewsMore.text = NSLocalizedString("more", comment: "")
        lblAll.text = NSLocalizedString("all", comment: "")
//        newsConView.isHidden = true
//        academyConView.isHidden = true
//        coffeeConView.isHidden = true
//        discussConView.isHidden = true
//        zectConView.isHidden = true
//        electronicConView.isHidden = true
//        videoConView.isHidden = true
        teamConView.isHidden = true
//        coffeeCollectionView.semanticContentAttribute = .forceRightToLeft
    }
    
    func getHomeData() {
        ProgressHUD.shared.show(view: view, msg: "")
        APIService.shared.getHomeData(completion: {
            error, res in
            ProgressHUD.shared.dismiss()
            
            if error != nil {
                self.showAlert(title: "", msg: error!.localizedDescription)
            } else {
                let response = res as! [String: Any]
                self.responseData = response
                let news = response["news"] as? [String: Any]
                if news == nil {
                    self.newsConView.isHidden = true
                } else {
//                    self.lblNewsTitle.text = (news!["name"] as! String)
                    let pages = news!["pages"] as! [Any]
                    for p in pages {
                        let page = NewsModel(dict: p as! [String: Any])
                        if self.news.count < 3 {
                            self.news.append(page)
                        }
                    }
                    
                    self.newsTableView.reloadData()
                    
                    if self.news.count == 0 {
                        self.newsConView.isHidden = true
                    } else {
                        self.newsConView.isHidden = false
                        if self.news.count == 1 {
                            self.newsHeight.constant = 150
                        } else if news!.count == 2 {
                            self.newsHeight.constant = 250
                        } else {
                            self.newsHeight.constant = 350
                        }
                    }
                }
                
                let academy = response["zeAcademy"] as? [String: Any]
                if academy == nil {
                    self.academyConView.isHidden = true
                    self.academyColConView.isHidden = true
                } else {
                    self.academyConView.isHidden = false
                    self.academyColConView.isHidden = false
//                    self.lblAcademyTitle.text = (academy!["name"] as! String)
//                    self.lblAcademyColTitle.text = (academy!["name"] as! String)
                
                    let levels = academy!["levels"] as! [Any]
                    for lv in levels {
                        let level = lv as! [String: Any]
                        let pages = level["pages"] as! [Any]
                        
                        for p in pages {
                            let page = NewsModel(dict: p as! [String: Any])
                            self.academies.append(page)
                        }
                    }
                    
                    self.academyCollectionView.reloadData()
                    
                    if LanguageManager.shared.currentLang == "ar" {
                        DispatchQueue.main.async {
                            self.academyCollectionView.scrollToMaxContentOffset(animated: true)
                        }
                    }
                }
                
                let coffee = response["zeCafe"] as? [String: Any]
                if coffee == nil {
                    self.coffeeConView.isHidden = true
                } else {
                    self.coffeeConView.isHidden = false
//                    self.lblCoffeeTitle.text = (coffee!["name"] as! String)
                    let categories = coffee!["categories"] as! [Any]
                    for cat in categories {
                        let category = cat as! [String: Any]
                        let pages = category["pages"] as! [Any]
                        for p in pages {
                            let page = NewsModel(dict: p as! [String: Any])
                            self.coffees.append(page)
                        }
                    }
                    
//                    self.coffees.reverse()
                    self.coffeeCollectionView.reloadData()
                    
                    if LanguageManager.shared.currentLang == "ar" {
                        DispatchQueue.main.async {
                            self.coffeeCollectionView.scrollToMaxContentOffset(animated: true)
                        }
                    }
                    
                }
                
                let discuss = response["digitalCurrenciesFromAToZ"] as? [String: Any]
                if discuss == nil {
                    self.discussConView.isHidden = true
                } else {
                    self.discussConView.isHidden = false
//                    self.discussTitle.text = (discuss!["name"] as! String)
                    
                    let categories = discuss!["categories"] as! [Any]
                    for cat in categories {
                        let category = cat as! [String: Any]
                        let pages = category["pages"] as! [Any]
                        for p in pages {
                            let page = NewsModel(dict: p as! [String: Any])
                            self.discusses.append(page)
                        }
                    }
                    
//                    self.discusses.reverse()
                    self.discussCollectionView.reloadData()
                    
                    if LanguageManager.shared.currentLang == "ar" {
                        DispatchQueue.main.async {
                            self.discussCollectionView.scrollToMaxContentOffset(animated: true)
                        }
                    }
                    
                }
                
                let zectionary = response["zectionary"] as? [String: Any]
                if zectionary == nil {
                    self.zectConView.isHidden = true
                } else {
                    self.zectConView.isHidden = false
//                    self.lblzectTitle.text = "قاموس زي للعملات الرقمية"//(zectionary!["name"] as! String)
                    let pages = zectionary!["pages"] as![Any]
                    for p in pages {
                        let page = NewsModel(dict: p as! [String: Any])
                        self.zectionaries.append(page)
                    }
                    
//                    self.zectionaries.reverse()
                    self.zectCollectionView.reloadData()
                    
                    if LanguageManager.shared.currentLang == "ar" {
                        DispatchQueue.main.async {
                            self.zectCollectionView.scrollToMaxContentOffset(animated: true)
                        }
                    }
                    
                }
                
                
                let electronics = response["electronicTrading"] as? [String: Any]
                if electronics == nil {
                    self.electronicConView.isHidden = true
                } else {
                    self.electronicConView.isHidden = false
//                    self.lblElectronicTitle.text = (discuss!["name"] as! String)
                    
                    let categories = electronics!["categories"] as! [Any]
                    for cat in categories {
                        let category = cat as! [String: Any]
                        let pages = category["pages"] as! [Any]
                        for p in pages {
                            let page = NewsModel(dict: p as! [String: Any])
                            self.electronics.append(page)
                        }
                    }
                    
//                    self.discusses.reverse()
                    self.electronicCollectionView.reloadData()
                    
                    if LanguageManager.shared.currentLang == "ar" {
                        DispatchQueue.main.async {
                            self.electronicCollectionView.scrollToMaxContentOffset(animated: true)
                        }
                    }
                    
                }
                
                let videos = response["videos"] as? [String: Any]
                if videos == nil {
                    self.videoConView.isHidden = true
                } else {
                    self.videoConView.isHidden = false
//                    self.lblVideoTitle.text = (videos!["name"] as! String)
                    let vs = videos!["videos"] as! [Any]
                    for v in vs {
                        let video = VideoModel(dict: v as! [String: Any])
                        if video.isActive {
                            self.videos.append(video)
                        }
                    }
                    
                    self.videoCollectionView.reloadData()
                    if LanguageManager.shared.currentLang == "ar" {
                        DispatchQueue.main.async {
                            self.videoCollectionView.scrollToMaxContentOffset(animated: true)
                        }
                    }
                    
                }
                
//                let team = response["team"] as? [String: Any]
//                if team == nil {
//                    self.teamConView.isHidden = true
//                } else {
//                    self.teamConView.isHidden = false
//                    self.lblTeamTitle.text = (team!["title"] as! String)
//                    let mems = team!["teamMembers"] as! [Any]
//                    for mem in mems {
//                        let member = TeamMember(dict: mem as! [String: Any])
//                        self.members.append(member)
//                    }
//
//                    self.teamCollectionView.reloadData()
//                    DispatchQueue.main.async {
//                        self.teamCollectionView.scrollToMaxContentOffset(animated: true)
//                    }
//                }
            }
        })
    }
    
    func getCurrencies() {
        APIService.shared.getCurrencies(completion: {
            error, res in
            
            if error != nil {
                self.showAlert(title: "", msg: error!.localizedDescription)
            } else {
                let response = res as! [Any]
                for cur in response {
                    let currency = CurrencyModel(dict: cur as! [String: Any])
                    self.currencies.append(currency)
                }
                
//                self.currencies.reverse()
                self.currencyCollectionView.reloadData()
                
                if LanguageManager.shared.currentLang == "ar" {
                    DispatchQueue.main.async {
                        self.currencyCollectionView.scrollToMaxContentOffset(animated: false)
                    }
                }
            }
        })
    }
    
    @IBAction func onMoreNews(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "News", bundle: nil)
        let vc = storyboard?.instantiateViewController(withIdentifier: "PageListViewController") as! PageListViewController
        vc.mainCategory = "News"
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func onMoreCurrency(_ sender: Any) {
        let storyboard = UIStoryboard(name: "CurrencyStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CurrencyViewController") as! CurrencyViewController
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func onMoreCaffee(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open_cafe"), object: nil)
    }
    
    @IBAction func onMoreAcademy(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Academy", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AcademyLevelViewController") as! AcademyLevelViewController
        vc.academyData = (responseData["zeAcademy"] as! [String: Any])
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func onMoreAcademyCol(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Academy", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AcademyLevelViewController") as! AcademyLevelViewController
        vc.academyData = (responseData["zeAcademy"] as! [String: Any])
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func onMoreDictionary(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PageListViewController") as! PageListViewController
        vc.mainCategory = "Zectionary"
//        vc.pageLevel = "1"
        navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func onMoreTeam(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TeamViewController") as! TeamViewController
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func onSearch(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        navigationController?.pushViewController(vc, animated: false)
    }
    
    
}

//Currrency CollectionView Delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1000 {
            let storyboard = UIStoryboard(name: "CurrencyStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CurrencyViewController") as! CurrencyViewController
            navigationController?.pushViewController(vc, animated: false)
        } else if collectionView.tag == 2000 {
            let page = coffees[indexPath.row]
            let vc = storyboard?.instantiateViewController(withIdentifier: "PageDetailViewController") as! PageDetailViewController
            vc.id = page.id
            navigationController?.pushViewController(vc, animated: false)
        } else if collectionView.tag == 3000 {
            
        } else if collectionView.tag == 4000 {
            let page = zectionaries[indexPath.row]
            let vc = storyboard?.instantiateViewController(withIdentifier: "PageDetailViewController") as! PageDetailViewController
            vc.id = page.id
            navigationController?.pushViewController(vc, animated: false)
            
        } else if collectionView.tag == 5000 {
            
        } else if collectionView.tag == 6000 {
            
        } else if collectionView.tag == 7000 {
            
        } else if collectionView.tag == 8000 {
            let page = academies[indexPath.row]
            let vc = storyboard?.instantiateViewController(withIdentifier: "PageDetailViewController") as! PageDetailViewController
            vc.id = page.id
            navigationController?.pushViewController(vc, animated: false)
            
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1000 {
            return self.currencies.count
        } else if collectionView.tag == 2000 {
            return coffees.count
        } else if collectionView.tag == 3000 {
            return discusses.count
        } else if collectionView.tag == 4000 {
            return zectionaries.count
        } else if collectionView.tag == 5000 {
            return electronics.count
        } else if collectionView.tag == 6000 {
            return videos.count
        } else if collectionView.tag == 7000 {
            return members.count
        } else if collectionView.tag == 8000 {
            return academies.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1000 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCollectionViewCell", for: indexPath) as! CurrencyCollectionViewCell
            let currency = currencies[indexPath.item]
            cell.lblTitle.text = currency.name
            cell.lblPrice.text = Common.shared.getCoinUnit() + String(format: " %.02f", Common.shared.getCoinPrice(currency: currency))
            cell.lblPercent.text = String(format: "%.02f", Common.shared.getCoin24hChange(currency: currency)) + "%"
            return cell
        } else if collectionView.tag == 2000{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoffeeCollectionViewCell", for: indexPath) as! CoffeeCollectionViewCell
            
            let page = coffees[indexPath.row]
            cell.imgCover.sd_setImage(with: URL(string: page.cover), placeholderImage: UIImage(named: "picture_placeholder"))
            cell.lblContent.text = page.title
            cell.lblDate.text = page.writer + " ● " +  Common.shared.convertDateString(inputDate: page.date)
            
            return cell
        } else if collectionView.tag == 3000 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscussCollectionViewCell", for: indexPath) as! DiscussCollectionViewCell
            let page = discusses[indexPath.item]
            cell.imgCover.sd_setImage(with: URL(string: page.cover), placeholderImage: UIImage(named: "picture_placeholder"))
            cell.lblContent.text = page.title
            cell.lblTime.text = page.writer + " ● " +  Common.shared.convertDateString(inputDate: page.date)
            cell.lblViewCnt.text = "\(page.readersCount)"
            return cell
        } else if collectionView.tag == 4000 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZectCollectionViewCell", for: indexPath) as! ZectCollectionViewCell
            
            let page = zectionaries[indexPath.row]
            cell.imgCover.sd_setImage(with: URL(string: page.cover), placeholderImage: UIImage(named: "picture_placeholder"))
            cell.lblContent.text = page.title
            cell.lblTime.text = page.writer + " ● " +  Common.shared.convertDateString(inputDate: page.date)
            return cell
        } else if collectionView.tag == 5000 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ElectronicCollectionViewCell", for: indexPath) as! ElectronicCollectionViewCell
            
            let page = zectionaries[indexPath.row]
            cell.imgCover.sd_setImage(with: URL(string: page.cover), placeholderImage: UIImage(named: "picture_placeholder"))
            cell.lblContent.text = page.title
            cell.lblTime.text = page.writer + " ● " +  Common.shared.convertDateString(inputDate: page.date)
            return cell
        } else if collectionView.tag == 6000 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
            let video = videos[indexPath.item]
            cell.lblTitle.text = video.title
            cell.lblContent.text = video.title
            cell.lblDuration.text = "00:00"
            cell.imgCover.sd_setImage(with: URL(string: video.photoUrl), placeholderImage: UIImage(named: "picture_placeholder"))
            
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = cell.imgBanner.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            cell.imgBanner.addSubview(blurEffectView)
            
            return cell
        } else if collectionView.tag == 7000 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberCollectionViewCell", for: indexPath) as! MemberCollectionViewCell
            let member = members[indexPath.item]
            cell.imgCover.sd_setImage(with: URL(string: member.cover), placeholderImage: UIImage(named: "picture_placeholder"))
            cell.lblName.text = member.name
            cell.lblDesc.text = member.desc
            return cell
        } else if collectionView.tag == 8000 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AcademyCollectionViewCell", for: indexPath) as! AcademyCollectionViewCell
            let page = academies[indexPath.item]
            cell.imgCover.sd_setImage(with: URL(string: page.cover), placeholderImage: UIImage(named: "picture_placeholder"))
            cell.lblName.text = page.title
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 1000 {
            let height = collectionView.frame.height
            let width = collectionView.frame.width / 3
            
            return CGSize(width: width, height: height)
        } else if collectionView.tag == 2000 {
            let height = collectionView.frame.height
            let width = (collectionView.frame.width - 10) / 2
            
            return CGSize(width: width, height: height)
        } else if collectionView.tag == 3000 {
            let height = collectionView.frame.height
            let width = collectionView.frame.width
            print(width)
            return CGSize(width: width, height: height)
        } else if collectionView.tag == 4000 {
            let height = collectionView.frame.height
            let width = (collectionView.frame.width - 10) / 2
            
            return CGSize(width: width, height: height)
        } else if collectionView.tag == 5000 {
            let height = collectionView.frame.height
            let width = (collectionView.frame.width - 10) / 2
            
            return CGSize(width: width, height: height)
        } else if collectionView.tag == 6000 {
            let height = collectionView.frame.height
            let width = collectionView.frame.width
            
            return CGSize(width: width, height: height)
            
            
        } else if collectionView.tag == 7000 {
            let height = collectionView.frame.height
            let width = (collectionView.frame.width - 10) / 2
            
            return CGSize(width: width, height: height)
        } else if collectionView.tag == 8000 {
            let height = collectionView.frame.height
            let width = collectionView.frame.width
            
            return CGSize(width: width, height: height)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}


//Content TableView Delegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1000 {
            if indexPath.row == 0 {
                return 150
            } else {
                return 100
            }
        } else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if tableView.tag == 1000 {
//            let new = news[indexPath.row]
//            let vc = storyboard?.instantiateViewController(withIdentifier: "PageDetailViewController") as! PageDetailViewController
//            vc.id = new.id
//            navigationController?.pushViewController(vc, animated: false)
//        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1000 {
            return news.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1000 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
            let new = news[indexPath.row]
            cell.lblContent.text = new.title
            cell.imgCover.sd_setImage(with: URL(string: new.cover), placeholderImage: UIImage(named: "picture_placeholder"))
            cell.lblTime.text = new.writer + " ● " +  Common.shared.convertDateString(inputDate: new.date)
            
            cell.btnCell.tag = indexPath.row
            cell.btnCell.addTarget(self, action: #selector(btnNewsTapped(sender:)), for: .touchUpInside)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    @objc func btnNewsTapped(sender: UIButton) {
        let index = sender.tag
        let new = news[index]
        let vc = storyboard?.instantiateViewController(withIdentifier: "PageDetailViewController") as! PageDetailViewController
        vc.id = new.id
        navigationController?.pushViewController(vc, animated: false)
    }
}
