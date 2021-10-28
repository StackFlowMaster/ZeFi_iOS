//
//  OnboardingViewController.swift
//  ZeFi
//
//  Created by Admin on 12/10/20.
//
//NSLocalizedString("app_name", comment: "")

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    @IBOutlet weak var btnForward: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var imgDot: UIImageView!
    
    @IBOutlet weak var lblFirstTitle: UILabel!
    @IBOutlet weak var lblFirstSub: UILabel!
    @IBOutlet weak var lblFirstContent: UILabel!
    
    @IBOutlet weak var lblSecondTitle: UILabel!
    @IBOutlet weak var lblSecondSub: UILabel!
    @IBOutlet weak var lblSecondContent: UILabel!
    
    @IBOutlet weak var lblThirdTitle: UILabel!
    @IBOutlet weak var lblThirdSub: UILabel!
    @IBOutlet weak var lblThirdContent: UILabel!
    
    var curPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    func configureView() {
        
        if LanguageManager.shared.currentLang == "ar" {
            btnForward.setBackgroundImage(UIImage(named: "ic_arrow_left"), for: .normal)
            btnBack.setBackgroundImage(UIImage(named: "ic_arrow_right"), for: .normal)
            imgDot.image = UIImage(named: "ic_dot_2")
        } else {
            btnForward.setBackgroundImage(UIImage(named: "ic_arrow_right"), for: .normal)
            btnBack.setBackgroundImage(UIImage(named: "ic_arrow_left"), for: .normal)
            imgDot.image = UIImage(named: "ic_dot_1")
        }
        
        firstView.isHidden = false
        secondView.isHidden = true
        thirdView.isHidden = true
        
        lblFirstTitle.text = NSLocalizedString("welecome", comment: "")
        lblFirstSub.text = NSLocalizedString("in_ze_fi", comment: "")
        lblFirstContent.text = NSLocalizedString("text1", comment: "")
        
        lblSecondTitle.text = NSLocalizedString("welcome", comment: "")
        lblSecondSub.text = NSLocalizedString("in_ze_fi", comment: "")
        lblSecondContent.text = NSLocalizedString("text2", comment: "")
        
        lblThirdTitle.text = NSLocalizedString("welcome", comment: "")
        lblThirdSub.text = NSLocalizedString("in_ze_fi", comment: "")
        lblThirdContent.text = NSLocalizedString("text3", comment: "")
    }
    
    @IBAction func onNext(_ sender: Any) {
        curPage += 1
        if curPage >= 2 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            navigationController?.pushViewController(vc, animated: false)
            
            UserDefaults.standard.setValue(true, forKey: "started")
        } else {
            firstView.isHidden = curPage != 0
            secondView.isHidden = curPage != 1
            thirdView.isHidden = curPage != 2
            
            setPageIcon(index: curPage)
        }
    }
    
    @IBAction func onPrev(_ sender: Any) {
        curPage -= 1
        if curPage == -1 {
            curPage = 0
        }

        firstView.isHidden = curPage != 0
        secondView.isHidden = curPage != 1
        thirdView.isHidden = curPage != 2
        
        setPageIcon(index: curPage)
    }
    
    func setPageIcon(index: Int) {
        if LanguageManager.shared.currentLang == "ar" {
            if index == 0 {
                imgDot.image = UIImage(named: "ic_dot_2")
            } else if index == 1 {
                imgDot.image = UIImage(named: "ic_dot_1")
            } else {
                imgDot.image = UIImage(named: "ic_dot_1")
            }
        } else {
            if index == 0 {
                imgDot.image = UIImage(named: "ic_dot_1")
            } else if index == 1 {
                imgDot.image = UIImage(named: "ic_dot_2")
            } else {
                imgDot.image = UIImage(named: "ic_dot_3")
            }
        }
    }
}


