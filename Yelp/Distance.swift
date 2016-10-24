//
//  Distance.swift
//  Yelp
//
//  Created by Dylan Miller on 10/23/16.
//  Copyright © 2016 Dylan Miller. All rights reserved.
//

import Foundation

// Protocol which allows enums to be used with combo box controls.
protocol ComboBoxEnum
{
    var description: String { get }
    
    static var count: Int { get }
}

// Model enum which represents distance.
enum Distance: Int, ComboBoxEnum
{
    case BestMatch = 0, Miles0_3, Miles1, Miles5, Miles20
    
    var description: String
    {
        switch self
        {
        case .BestMatch:
            return "Best Match"
        case .Miles0_3:
            return "0.3 miles"
        case .Miles1:
            return "1 mile"
        case .Miles5:
            return "5 miles"
        case .Miles20:
            return "20 miles"
        }
    }
    
    var miles: Double?
    {
        switch self
        {
        case .BestMatch:
            return nil
        case .Miles0_3:
            return 0.3
        case .Miles1:
            return 1.0
        case .Miles5:
            return 5.0
        case .Miles20:
            return 20.0
        }
    }
    
    var meters: Double?
    {
        if let miles = miles
        {
            return miles / Constants.MilesPerMeter
        }
        else
        {
            return nil
        }
    }

    
    static let allValues = [BestMatch, Miles0_3, Miles1, Miles5, Miles20]
    static var count: Int
    {
        return allValues.count
    }
}
