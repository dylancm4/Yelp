//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by Dylan Miller on 10/21/16.
//  Copyright © 2016 Dylan Miller. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell
{
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!    
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        // Initialization code
        businessImageView.layer.cornerRadius = 3
        businessImageView.clipsToBounds = true
    }
    
    // Set the cell contents based on the specified parameters.
    func setData(row: Int, business: Business)
    {
        if let imageUrl = business.imageUrl
        {
            setImage(imageView: businessImageView, imageUrl: imageUrl)
        }
        else
        {
            businessImageView.image = nil
        }
        if let name = business.name
        {
            nameLabel.text = "\(row+1). \(name)"
        }
        else
        {
            nameLabel.text = nil
        }
        if let ratingImageUrl = business.ratingImageUrl
        {
            setImage(imageView: ratingImageView, imageUrl: ratingImageUrl)
        }
        else
        {
            ratingImageView.image = nil
        }
        if let reviewCount = business.reviewCount
        {
            reviewCountLabel.text = "\(reviewCount) Reviews"
        }
        else
        {
            reviewCountLabel.text = nil
        }
        addressLabel.text = business.address
        categoriesLabel.text = business.categories
        if let distanceMiles = business.distanceMiles
        {
            distanceLabel.text = String(format: "%.1f mi", distanceMiles)
        }
        else
        {
            distanceLabel.text = nil
        }
    }
    
    // Fade in the specified image if it is not cached, or simply update
    // the image if it was cached.
    func setImage(imageView: UIImageView, imageUrl: URL)
    {
        let imageRequest = URLRequest(url: imageUrl)
        imageView.setImageWith(
            imageRequest,
            placeholderImage: nil,
            success: { (imageRequest, imageResponse, image) -> Void in
                
                let imageIsCached = imageResponse == nil
                if !imageIsCached
                {
                    imageView.alpha = 0.0
                    imageView.image = image
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        imageView.alpha = 1.0
                    })
                }
                else
                {
                    imageView.image = image
                }
            },
            failure: { (imageRequest, imageResponse, error) -> Void in
                imageView.image = nil
        })
    }
}
