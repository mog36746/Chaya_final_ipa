//
//  CustomeItemTableViewCell.swift
//  Chaya
//
//  Created by MI on 5/3/20.
//  Copyright © 2020 Mog. All rights reserved.
//

import UIKit

class CustomeItemTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var checkmark: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
