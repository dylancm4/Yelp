//
//  Business.swift
//  Yelp
//
//  Created by Dylan Miller on 10/21/16.
//  Copyright © 2016 Dylan Miller. All rights reserved.
//

import UIKit

class Business: NSObject
{
    let name: String?
    let address: String?
    let imageUrl: URL?
    let categories: String?
    let distanceMiles: Double?
    let ratingImageUrl: URL?
    let reviewCount: Int?
    
    init(dictionary: NSDictionary)
    {
        name = dictionary["name"] as? String
        
        var addressAndNeighborhood  = ""
        if let location = dictionary["location"] as? NSDictionary
        {
            if let addressArray = location["address"] as? NSArray,
                addressArray.count > 0,
                let address = addressArray[0] as? String
            {
                addressAndNeighborhood = address
            }
            
            if let neighborhoods = location["neighborhoods"] as? NSArray,
                neighborhoods.count > 0,
                let neighborhood = neighborhoods[0] as? String
            {
                if !addressAndNeighborhood.isEmpty
                {
                    addressAndNeighborhood += ", "
                }
                addressAndNeighborhood += neighborhood
            }
        }
        address = !addressAndNeighborhood.isEmpty ? addressAndNeighborhood : nil
        
        if let imageUrlString = dictionary["image_url"] as? String
        {
            imageUrl = URL(string: imageUrlString)!
        }
        else
        {
            imageUrl = nil
        }
        
        if let categoriesArray = dictionary["categories"] as? [[String]]
        {
            var categoryNames = [String]()
            for category in categoriesArray
            {
                let categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joined(separator: ", ")
        }
        else
        {
            categories = nil
        }
        
        if let distanceMeters = dictionary["distance"] as? NSNumber
        {
            distanceMiles = Constants.MilesPerMeter * distanceMeters.doubleValue
        }
        else
        {
            distanceMiles = nil
        }
        
        if let ratingImgUrlLargeString = dictionary["rating_img_url_large"] as? String
        {
            ratingImageUrl = URL(string: ratingImgUrlLargeString)
        }
        else
        {
            ratingImageUrl = nil
        }
        
        if let reviewCountNumber = dictionary["review_count"] as? NSNumber
        {
            reviewCount = reviewCountNumber.intValue
        }
        else
        {
            reviewCount = nil
        }
    }
    
    class func businesses(dictionaryArray: [NSDictionary]) -> [Business]
    {
        var businesses = [Business]()
        for dictionary in dictionaryArray
        {
            let business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
}
