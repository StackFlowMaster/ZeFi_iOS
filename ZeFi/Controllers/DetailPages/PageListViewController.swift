//
//  PageListViewController.swift
//  ZeFi
//
//  Created by Admin on 12/13/20.
//

import UIKit
import PickerButton

class PageListViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblBack: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var levelConView: UIView!
    @IBOutlet weak var textLevel: UITextField!
    var levelPickerView: UIPickerView!
    
    var levels: [String] = []
    
    var allPages: [NewsModel] = []
    var pages: [NewsModel] = []
    var mainCategory = ""
    var pageLevel = ""
    var pageCount = 100
//    var hasRelatedPages = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        getData()
    }

    func configureView() {
        topViewHeight.constant = 100
        topView.layer.cornerRadius = 20
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        lblTitle.text = ""
        
        if LanguageManager.shared.currentLang == "ar" {
            btnBack.setImage(UIImage(named: "ic_arrow_right"), for: .normal)
        } else {
            btnBack.setImage(UIImage(named: "ic_arrow_left"), for: .normal)
        }
        
        lblBack.text = NSLocalizedString("back", comment: "")
        
        setupLevelTextField(textField: textLevel)
        if LanguageManager.shared.currentLang == "ar" {
            textLevel.textAlignment = .right
        } else {
            textLevel.textAlignment = .left
        }
    }
    
    func setupLevelTextField(textField: UITextField) {
        self.levelPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.levelPickerView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        textField.inputView = self.levelPickerView
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 12.0 / 255, green: 211.0 / 255, blue: 214.0 / 255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: NSLocalizedString("done", comment: ""), style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: NSLocalizedString("cancel", comment: ""), style: .plain, target: self, action: #selector(self.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        self.levelPickerView.delegate = self
    }
    
    @objc func doneClick() {
        let index = levelPickerView.selectedRow(inComponent: 0)
        selectOption(index: index)
    }
    
    @objc func cancelClick() {
        textLevel.resignFirstResponder()
    }
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    func getData() {
        ProgressHUD.shared.show(view: view, msg: "")
        APIService.shared.getAllPages(category: mainCategory, level: pageLevel, pageCount: pageCount, completion: {
            error, res in
            ProgressHUD.shared.dismiss()

            if error != nil {
                self.showAlert(title: "", msg: error!.localizedDescription)
            } else {
                let response = res as! [String: Any]

                self.lblTitle.text = (response["name"] as! String)
                if self.mainCategory == "Zectionary" {
                    self.lblTitle.text = NSLocalizedString("dictionary", comment: "")
                }
                let categories = response["categories"] as! [Any]
                self.levels = []
                for cat in categories {
                    let category = CategoryModel(dict: cat as! [String: Any])
                    
                    for page in category.pages {
                        self.allPages.append(page)
                        
                        let level = page.pageLevel["value"] as? String
                        if level == nil {
                            continue
                        } else {
                            var isExist = false
                            for op in self.levels {
                                if op == level! {
                                    isExist = true
                                    break
                                }
                            }
                            
                            if !isExist {
                                self.levels.append(level!)
                            }
                        }
                    }
                }
                
                if self.levels.count <= 1 {
                    self.topViewHeight.constant = 100
                    self.levelConView.isHidden = true
                    self.pages = self.allPages
                    self.collectionView.reloadData()
                } else {
                    self.topViewHeight.constant = 160
                    self.levelConView.isHidden = false
                    
                    if self.mainCategory == "ZeAcademy" {
                        if categories.count == 2 {
                            let category = CategoryModel()
                            category.name = NSLocalizedString("advanced", comment: "")

                            self.levels.append(NSLocalizedString("advanced", comment: ""))
                        }
                    }
                    
                    self.selectOption(index: 0)
                }
            }
        })
    }
    
    func selectOption(index: Int) {
        let option = self.levels[index]
        self.textLevel.text = self.levels[index]
        textLevel.resignFirstResponder()
        pages = []
        for page in allPages {
            let level = page.pageLevel["value"] as? String
            if level == nil {
                continue
            }
            if level == option {
                pages.append(page)
            }
        }
        
        collectionView.reloadData()
    }

}

extension PageListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let page = pages[indexPath.item]
        let vc = storyboard?.instantiateViewController(withIdentifier: "PageDetailViewController") as! PageDetailViewController
        vc.id = page.id
        navigationController?.pushViewController(vc, animated: false)
        
    }
}

extension PageListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCollectionViewCell", for: indexPath) as! PageCollectionViewCell
        
        let page = pages[indexPath.row]
        cell.imgCover.sd_setImage(with: URL(string: page.cover), placeholderImage: UIImage(named: "picture_placeholder"))
        cell.lblContent.text = page.title
        cell.lblDate.text = page.writer + " ● " +  Common.shared.convertDateString(inputDate: page.date)
        
        return cell
    }
}

extension PageListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width - 10) / 2
        let height = width * 1.2
        return CGSize(width: width, height: height)
    }
}

extension PageListViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return levels[row]
    }
}

extension PageListViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        levels.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

