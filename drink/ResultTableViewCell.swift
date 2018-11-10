//
//  ResultTableViewCell.swift
//  drink
//
//  Created by PengDa Cheng on 2018/10/24.
//  Copyright © 2018年 PengDa Cheng. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var priceLab: UILabel!
    @IBOutlet weak var drinkLab: UILabel!
    @IBOutlet weak var iceLab: UILabel!
    @IBOutlet weak var sugerLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
