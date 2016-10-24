//
//  ComboBoxTableViewCell.swift
//  Yelp
//
//  Created by Dylan Miller on 10/23/16.
//  Copyright © 2016 Dylan Miller. All rights reserved.
//

import UIKit

class ComboBoxTableViewCell: UITableViewCell
{
    @IBOutlet weak var itemLabel: UILabel!
    
    // Set the cell contents based on the specified parameters.
    func setData(labelText: String?)
    {
        itemLabel.text = labelText
    }
}
