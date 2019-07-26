//
//  ContactBirthdayTableViewCell.swift
//  FFBirthdays
//
//  Created by zhou on 2019/7/25.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class ContactBirthdayTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var imgContactImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgContactImage.layer.cornerRadius = 25.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
