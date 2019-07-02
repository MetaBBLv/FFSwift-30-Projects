//
//  FFNewsTableViewCell.swift
//  FFSimpleRSSReader
//
//  Created by zhou on 2019/7/2.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

enum CellState {
    case expanded
    case collapsed
}

class FFNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 4
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
