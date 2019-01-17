//
//  TableViewCell.swift
//  ThingsToDo
//
//  Created by Rijo George on 1/8/19.
//  Copyright © 2019 Rijo George. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var todoName: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell (name: String, isDone: Bool) {
        todoName.text = name
        checkImage.isHidden = !isDone
    }
    
}
