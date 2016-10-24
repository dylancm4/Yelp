//
//  YelpClient.swift
//  Yelp
//
//  Created by Dylan Miller on 10/21/16.
//  Copyright © 2016 Dylan Miller. All rights reserved.
//

import UIKit

import AFNetworking
import BDBOAuth1Manager
import MBProgressHUD

let myYelpConsumerKey = "-jmLp_6s443y37hvZZE64Q"
let myYelpConsumerSecret = "_wmGuRLbUsGrxKILIms9FTuLpYM"
let myYelpToken = "23kZDMPuPJehzQV7dJ0I27HQ_3JgvBVQ"
let myYelpTokenSecret = "JaK1zA3sfTaTAmk1TPvjB6r6HiA"

enum YelpSortMode: Int, ComboBoxEnum
{
    case BestMatched = 0, Distance, HighestRated

    var description: String
    {
        switch self
        {
        case .BestMatched:
            return "Best Match"
        case .Distance:
            return "Distance"
        case .HighestRated:
            return "Rating"
        }
    }

    static let allValues = [BestMatched, Distance, HighestRated]    
    static var count: Int
    {
        return allValues.count
    }
}

class YelpClient: BDBOAuth1RequestOperationManager
{
    var yelpToken: String!
    var yelpTokenSecret: String!
    
    static let sharedInstance = YelpClient(yelpConsumerKey: myYelpConsumerKey, yelpConsumerSecret: myYelpConsumerSecret, yelpToken: myYelpToken, yelpTokenSecret: myYelpTokenSecret)
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    init(yelpConsumerKey: String!, yelpConsumerSecret: String!, yelpToken: String!, yelpTokenSecret: String!)
    {
        self.yelpToken = yelpToken
        self.yelpTokenSecret = yelpTokenSecret
        let baseUrl = URL(string: "https://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret);
        
        let token = BDBOAuth1Credential(token: yelpToken, secret: yelpTokenSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(_ term: String, view: UIView, completion: @escaping ([Business]?, Error?) -> Void) -> AFHTTPRequestOperation
    {
        return searchWithTerm(term, sort: nil, categories: nil, deals: nil, radiusMeters: nil, offset: nil, view: view, completion: completion)
    }
    
    func searchWithTerm(_ term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, radiusMeters: Double?, offset: Int?, view: UIView, completion: @escaping ([Business]?, Error?) -> Void) -> AFHTTPRequestOperation
    {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        
        // Default the location to San Francisco
        var parameters: [String : AnyObject] = [
            "term": term as AnyObject,
            "ll": "37.785771,-122.406165" as AnyObject]
        
        if let sort = sort
        {
            parameters["sort"] = sort.rawValue as AnyObject?
        }
        
        if let categories = categories,
            categories.count > 0
        {
            parameters["category_filter"] = categories.joined(separator: ",") as AnyObject?
        }
        
        if let deals = deals
        {
            parameters["deals_filter"] = deals as AnyObject?
        }
        
        if let radiusMeters = radiusMeters
        {
            let radiusMetersNum = NSNumber(value: min(radiusMeters, Constants.Yelp.MaxRadiusMeters))
            parameters["radius_filter"] = radiusMetersNum as AnyObject?
        }
        
        if let offset = offset
        {
            let offsetNum = NSNumber(value: offset)
            parameters["offset"] = offsetNum as AnyObject?
        }
        
        //print(parameters)
        
        // Display progress HUD before the request is made.
        MBProgressHUD.showAdded(to: view, animated: true)
        
        return self.get(
            "search",
            parameters: parameters,
            success: { (operation: AFHTTPRequestOperation, response: Any) -> Void in
                
                MBProgressHUD.hide(for: view, animated: true)
                
                if let response = response as? [String: Any],
                    let dictionaries = response["businesses"] as? [NSDictionary]
                {
                    completion(Business.businesses(dictionaryArray: dictionaries), nil)
                }
            },
            failure: { (operation: AFHTTPRequestOperation?, error: Error) -> Void in
                
                MBProgressHUD.hide(for: view, animated: true)

                completion(nil, error)
            })!
    }
}
