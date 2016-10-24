//
//  SwitchTableViewCell.swift
//  Yelp
//
//  Created by Dylan Miller on 10/22/16.
//  Copyright © 2016 Dylan Miller. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class
{
    func switchTableViewCell(_ switchTableViewCell: SwitchTableViewCell, valueChanged isOn: Bool)
}

class SwitchTableViewCell: UITableViewCell
{
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    
    weak var delegate: SwitchTableViewCellDelegate?

    @IBAction func onSwitchValueChanged(_ sender: UISwitch)
    {
        delegate?.switchTableViewCell(self, valueChanged: onSwitch.isOn)
    }
    
    // Set the cell contents based on the specified parameters.
    func setData(labelText: String?, isOn : Bool?, delegate: SwitchTableViewCellDelegate?)
    {
        switchLabel.text = labelText
        onSwitch.isOn = isOn ?? false
        self.delegate = delegate
    }
}
