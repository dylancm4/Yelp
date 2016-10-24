//
//  Filters.swift
//  Yelp
//
//  Created by Dylan Miller on 10/22/16.
//  Copyright © 2016 Dylan Miller. All rights reserved.
//

import Foundation

// Model struct which represents the filters.
struct Filters
{
    var offeringDeal = false
    var distance = Distance.BestMatch
    var sort = YelpSortMode.BestMatched
    var categories: [String]?
    
    // Add the specified category to the categories[] array.
    mutating func addCategory(category: String)
    {
        if categories == nil
        {
            categories = [String]()
        }
        categories!.append(category)
    }

    // Remove the specified category from the categories[] array.
    mutating func removeCategory(category: String)
    {
        if categories != nil
        {
            if let index = categories!.index(of: category)
            {
                categories!.remove(at: index)
            }
        }
    }
    
    // Returns true if the specified category is in the categories[] array,
    // false otherwise.
    func isCategoryDefined(category: String) -> Bool
    {
        if categories != nil && categories!.index(of: category) != nil
        {
            return true
        }
        else
        {
            return false
        }
    }
}
