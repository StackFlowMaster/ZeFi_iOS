//
//  MemberTableViewCell.swift
//  ZeFi
//
//  Created by Admin on 12/12/20.
//

import UIKit

class MemberTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPosition: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnLinkedIn: UIButton!
    @IBOutlet weak var btnTelegram: UIButton!
    @IBOutlet weak var btnTwitter: UIButton!
    @IBOutlet weak var btnYoutube: UIButton!
    @IBOutlet weak var btnInstagram: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
