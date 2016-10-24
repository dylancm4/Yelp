//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Dylan Miller on 10/21/16.
//  Copyright © 2016 Dylan Miller. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!

    var searchBar: UISearchBar!
    var searchSettings = SearchSettings()
    var businesses: [Business]?
    var scrollLoadingData = false

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Set the navigationBar colors.
        navigationController!.navigationBar.barTintColor = UIColor(red: CGFloat(Constants.YelpRed.Red), green: CGFloat(Constants.YelpRed.Green), blue: CGFloat(Constants.YelpRed.Blue), alpha: 1.0)
        navigationController!.navigationBar.tintColor = UIColor.white

        // Set up the tableView.
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Add a UISearchBar to the navigation bar.
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        // Perform a search when the view controller loads.
        performSearch()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Set self as the filtersViewController delegate.
        let navigationController = segue.destination as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
        filtersViewController.filters = searchSettings.filters
    }
    
    func performSearch(offset: Int? = nil)
    {
        searchSettings.performSearch(
            offset: offset,
            view: view,
            completion: { (businesses: [Business]?, error: Error?) -> Void in
                
                if offset != nil
                {
                    // Infinite scroll.
                    self.scrollLoadingData = false
                    self.businesses?.append(contentsOf: businesses!)
                }
                else
                {
                    self.businesses = businesses
                    
                    // Reset the tableView to the top.
                    self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
                }
                
                self.tableView.reloadData()
        })
        
    }
}

// UITableView methods
extension BusinessesViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let businesses = businesses
        {
            return businesses.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell") as! BusinessTableViewCell
        
        // Set the cell contents.
        cell.setData(row: indexPath.row, business: businesses![indexPath.row])
        
        return cell
    }
}

// UIScrollView methods
extension BusinessesViewController: UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if (!scrollLoadingData)
        {
            // Calculate the position of one screen length before the bottom
            // of the results.
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if (scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging)
            {
                scrollLoadingData = true
                
                // Perform a search to load more results.
                performSearch(offset: businesses!.count)
            }
        }
    }
}

// UISearchBar methods
extension BusinessesViewController: UISearchBarDelegate
{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchSettings.term = searchBar.text!
        performSearch()
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.showsCancelButton = false
        searchBar.text = searchSettings.term
        searchBar.resignFirstResponder()
    }
}

// FiltersViewController methods
extension BusinessesViewController: FiltersViewControllerDelegate
{
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: Filters)
    {
        searchSettings.filters = filters
        performSearch()
    }
}
