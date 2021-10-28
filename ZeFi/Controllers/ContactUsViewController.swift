//
//  ContactUsViewController.swift
//  ZeFi
//
//  Created by Admin on 12/12/20.
//

import UIKit

class ContactUsViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblBack: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblContent: UILabel!
    
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var txtTopic: UITextField!
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var txtMessage: UITextView!
    
    @IBOutlet weak var btnSend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
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
        
        lblTitle.text = NSLocalizedString("connect_us", comment: "")
        
        lblContent.text = NSLocalizedString("text4", comment: "")
        
        lblPhone.text = NSLocalizedString("phone", comment: "")
        txtPhone.placeholder = NSLocalizedString("enter_your_number", comment: "")
        
        lblEmail.text = NSLocalizedString("email", comment: "")
        txtEmail.placeholder = NSLocalizedString("enter_your_email", comment: "")
        
        lblSubject.text = NSLocalizedString("subject", comment: "")
        txtTopic.placeholder = NSLocalizedString("enter_subject", comment: "")
        
        lblMessage.text = NSLocalizedString("message", comment: "")
        txtMessage.placeholder = NSLocalizedString("enter_your_message", comment: "")
        
        btnSend.setTitle(NSLocalizedString("send", comment: ""), for: .normal)
    }
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        
        let email = txtEmail.text ?? ""
        let phone = txtPhone.text ?? ""
        let subject = txtTopic.text ?? ""
        let content = txtMessage.text ?? ""
        
        
        if phone.count == 0 {
            showAlert(title: "", msg: NSLocalizedString("enter_your_number", comment: ""))
            return
        }
        
        if email.count == 0 {
            showAlert(title: "", msg: NSLocalizedString("enter_your_email", comment: ""))
            return
        }
        
        if subject.count == 0 {
            showAlert(title: "", msg: NSLocalizedString("enter_subject", comment: ""))
            return
        }
        
        if content.count == 0 {
            showAlert(title: "", msg: NSLocalizedString("enter_your_message", comment: ""))
            return
        }
        
//        if email.count == 0 || phone.count == 0 || subject.count == 0 || content.count == 0 {
//            showAlert(title: "Error", msg: "Please enter all fields.")
//            return
//        }
        
        let body: [String: Any] = [
            "email": email,
            "phoneNumber": phone,
            "subject": subject,
            "content": content
        ]
        
        ProgressHUD.shared.show(view: view, msg: "")
        
        APIService.shared.sendContactData(body: body, completion: {
            error, res in
            
            ProgressHUD.shared.dismiss()
            
            if error != nil {
                self.showAlert(title: "", msg: error!.localizedDescription)
            } else {
                self.navigationController?.popViewController(animated: false)
            }
        })
    }
}
