//
//  CheckButtonTableViewCell.swift
//  Yelp
//
//  Created by Dylan Miller on 10/23/16.
//  Copyright © 2016 Dylan Miller. All rights reserved.
//

import UIKit

protocol CheckButtonTableViewCellDelegate: class
{
    func checkButtonTableViewCell(_ checkButtonTableViewCell: CheckButtonTableViewCell, valueChanged isChecked: Bool)
}

class CheckButtonTableViewCell: UITableViewCell
{
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var checkButton: CheckButton!

    weak var delegate: CheckButtonTableViewCellDelegate?

    @IBAction func onCheckButton(_ sender: CheckButton)
    {
        delegate?.checkButtonTableViewCell(self, valueChanged: checkButton.isChecked)
    }
    
    // Set the cell contents based on the specified parameters.
    func setData(labelText: String?, isChecked : Bool?, delegate: CheckButtonTableViewCellDelegate?)
    {
        checkLabel.text = labelText
        checkButton.isChecked = isChecked ?? false
        self.delegate = delegate
    }
}
