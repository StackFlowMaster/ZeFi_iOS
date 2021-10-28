//
//  AcademyLevelTableViewCell.swift
//  ZeFi
//
//  Created by Admin on 12/12/20.
//

import UIKit

class AcademyLevelTableViewCell: UITableViewCell {

    @IBOutlet weak var bkView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnCell: UIButton!
    @IBOutlet weak var topMargin: NSLayoutConstraint!
    @IBOutlet weak var imgArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
