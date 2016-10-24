//
//  SearchSettings.swift
//  Yelp
//
//  Created by Dylan Miller on 10/22/16.
//  Copyright © 2016 Dylan Miller. All rights reserved.
//

import UIKit

// Model class which represents the search settings.
class SearchSettings
{
    var term = ""
    var filters = Filters()
    
    func performSearch(offset: Int?, view: UIView, completion: @escaping ([Business]?, Error?) -> Void)
    {
        _ = YelpClient.sharedInstance.searchWithTerm(
            term,
            sort: filters.sort,
            categories: filters.categories,
            deals: filters.offeringDeal,
            radiusMeters: filters.distance.meters,
            offset: offset,
            view: view,
            completion: completion)
    }
}
