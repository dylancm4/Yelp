//
//  CheckButton.swift
//  Yelp
//
//  Created by Dylan Miller on 10/23/16.
//  Copyright © 2016 Dylan Miller. All rights reserved.
//

import UIKit

class CheckButton: UIButton
{
    let checkboxOnImage = UIImage(named: "Checkbox-On")!
    let checkboxOffImage = UIImage(named: "Checkbox-Off")!
    
    var isChecked = false
    {
        didSet
        {
            updateImage()
        }
    }
    
    override func awakeFromNib()
    {
        addTarget(self, action: #selector(onTouchUpInside(_:)), for: UIControlEvents.touchUpInside)
        updateImage()
    }
    
    func onTouchUpInside(_ sender: UIButton)
    {
        if sender == self
        {
            isChecked = !isChecked
        }
    }
    
    func updateImage()
    {
        setImage(isChecked ? checkboxOnImage : checkboxOffImage, for: .normal)
    }
}
