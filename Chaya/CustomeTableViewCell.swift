//
//  CustomeTableViewCell.swift
//  Chaya
//
//  Created by MI on 4/27/20.
//  Copyright © 2020 Mog. All rights reserved.
//

import UIKit
protocol AddButtonDelegate {
    func onclick(id: String)
}
class CustomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var cellDelegate: AddButtonDelegate?
    var index: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onAddbuttonPress(_ sender: Any) {
        cellDelegate?.onclick(id: index!)
    }
    
}
