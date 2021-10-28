//
//  CoffeeViewController.swift
//  ZeFi
//
//  Created by Admin on 12/11/20.
//
//NSLocalizedString("more", comment: "")

import UIKit

class CoffeeViewController: UIViewController {

    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var levelConView: UIView!
    @IBOutlet weak var textLevel: UITextField!
    var levelPickerView: UIPickerView!
    
    var coffeeDate: [String: Any]!
    var categories: [CategoryModel] = []
    var selectedCategory = CategoryModel()
    
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
        
        lblTitle.text = NSLocalizedString("ze_cafe", comment: "")
        if LanguageManager.shared.currentLang == "ar" {
            textLevel.textAlignment = .right
        } else {
            textLevel.textAlignment = .left
        }
        setupLevelTextField(textField: textLevel)
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
    
    func selectOption(index: Int) {
        selectedCategory = categories[index]
        textLevel.text = selectedCategory.name
        textLevel.resignFirstResponder()
        collectionView.reloadData()
    }
    
    func getData() {
        ProgressHUD.shared.show(view: view, msg: "")
        APIService.shared.getAllPages(category: "ZeCafe", level: "", pageCount: 100, completion: {
            error, res in
            ProgressHUD.shared.dismiss()
            
            if error != nil {
                self.showAlert(title: "", msg: error!.localizedDescription)
            } else {
                let response = res as! [String: Any]
                
                
//                self.lblTitle.text = (response["name"] as! String)
                let categories = response["categories"] as! [Any]
                for cat in categories {
                    let category = CategoryModel(dict: cat as! [String: Any])
                    self.categories.append(category)
                }
                
                if self.categories.count > 0 {
                    self.selectOption(index: 0)
                }
            }
        })
    }

}

extension CoffeeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let page = selectedCategory.pages[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "PageDetailViewController") as! PageDetailViewController
        vc.id = page.id
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension CoffeeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedCategory.pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoffeeCollectionViewCell", for: indexPath) as! CoffeeCollectionViewCell
        
        let page = selectedCategory.pages[indexPath.row]
        cell.imgCover.sd_setImage(with: URL(string: page.cover), placeholderImage: UIImage(named: "picture_placeholder"))
        cell.lblContent.text = page.title
        cell.lblDate.text = page.writer + " ● " +  Common.shared.convertDateString(inputDate: page.date)
        
        return cell
    }
}

extension CoffeeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width - 10) / 2
        let height = width * 1.2
        return CGSize(width: width, height: height)
    }
}

extension CoffeeViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].name
    }
}

extension CoffeeViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categories.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
