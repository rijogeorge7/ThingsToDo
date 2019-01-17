//
//  ItemCell.swift
//  ThingsToDo
//
//  Created by Rijo George on 1/8/19.
//  Copyright © 2019 Rijo George. All rights reserved.
//

import UIKit
class ItemCell : UITableViewCell {
    
    @IBOutlet weak var todoName: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    func configureCell (name: String, isDone: Bool) {
        todoName.text = name
        //checkImage.isHidden = !isDone
    }
}
