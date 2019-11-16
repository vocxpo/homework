//
//  TodoCellTableViewCell.swift
//  TodoDemo
//
//  Created by 呉翰 on 2019/11/17.
//  Copyright © 2019 呉翰. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var completeSwitch: UISwitch!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
