//
//  CurrencyViewController.swift
//  ZeFi
//
//  Created by Admin on 12/12/20.
//

import UIKit
import SDWebImageSVGCoder
import SVGKit

class CurrencyViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblBack: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var currencies: [CurrencyModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        getCurrencies()
    }
    

    func configureView() {
        topView.layer.cornerRadius = 20
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func getCurrencies() {
        ProgressHUD.shared.show(view: view, msg: "")
        APIService.shared.getCurrencies(completion: {
            error, res in
            ProgressHUD.shared.dismiss()
            if error != nil {
                self.showAlert(title: "", msg: error!.localizedDescription)
            } else {
                let response = res as! [Any]
                for cur in response {
                    let currency = CurrencyModel(dict: cur as! [String: Any])
                    self.currencies.append(currency)
                }
                
                self.collectionView.reloadData()
                
//                DispatchQueue.main.async {
//                    self.collectionView.scrollToMaxContentOffset(animated: false)
//                }
            }
        })
        
        lblTitle.text = NSLocalizedString("coin_price", comment: "")
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
}

extension CurrencyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCollectionViewCell", for: indexPath) as! CurrencyCollectionViewCell
        let currency = currencies[indexPath.item]
        cell.lblTitle.text = currency.name
        cell.lblPrice.text = Common.shared.getCoinUnit() + String(format: " %.2f", Common.shared.getCoinPrice(currency: currency))
        cell.lblPercent.text = String(format: "%.2f", Common.shared.getCoin24hChange(currency: currency)) + "%"
        
        print(currency.lastChangeImage)
        cell.imgChange.sd_setImage(with: URL(string: currency.lastChangeImage))
        
        return cell
    }
}

extension CurrencyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currency = currencies[indexPath.item]
        let storyboard = UIStoryboard(name: "CurrencyStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CurrencyDetailViewController") as! CurrencyDetailViewController
        vc.currency = currency
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension CurrencyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = (collectionView.frame.width - 10) / 2
        let height = width * 1.2
        return CGSize(width: width, height: height)
    }
}
