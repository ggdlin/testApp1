//
//  TableViewCell.swift
//  testApp1
//
//  Created by Sergey Ivanov on 30.08.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageForMe: UIImageView!
    @IBOutlet weak var textFieldForMe: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
