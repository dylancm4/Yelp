//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Dylan Miller on 10/22/16.
//  Copyright © 2016 Dylan Miller. All rights reserved.
//

import UIKit

protocol FiltersViewControllerDelegate: class
{
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: Filters)
}

class FiltersViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: FiltersViewControllerDelegate?
    var filters = Filters()
    enum Section: Int
    {
        case OfferingDeal = 0, Distance, SortBy, Categories

        static let allValues = [OfferingDeal, Distance, SortBy, Categories]
        static var count: Int
        {
            return allValues.count
        }
    }
    var distanceComboBoxExpanded = false
    var sortByComboBoxExpanded = false
    var categoriesExpanded = false
    let categories : [[String:String]] = [
        ["name" : "Afghan", "code": "afghani"],
        ["name" : "African", "code": "african"],
        ["name" : "American, New", "code": "newamerican"],
        ["name" : "American, Traditional", "code": "tradamerican"],
        ["name" : "Arabian", "code": "arabian"],
        ["name" : "Argentine", "code": "argentine"],
        ["name" : "Armenian", "code": "armenian"],
        ["name" : "Asian Fusion", "code": "asianfusion"],
        ["name" : "Asturian", "code": "asturian"],
        ["name" : "Australian", "code": "australian"],
        ["name" : "Austrian", "code": "austrian"],
        ["name" : "Baguettes", "code": "baguettes"],
        ["name" : "Bangladeshi", "code": "bangladeshi"],
        ["name" : "Barbeque", "code": "bbq"],
        ["name" : "Basque", "code": "basque"],
        ["name" : "Bavarian", "code": "bavarian"],
        ["name" : "Beer Garden", "code": "beergarden"],
        ["name" : "Beer Hall", "code": "beerhall"],
        ["name" : "Beisl", "code": "beisl"],
        ["name" : "Belgian", "code": "belgian"],
        ["name" : "Bistros", "code": "bistros"],
        ["name" : "Black Sea", "code": "blacksea"],
        ["name" : "Brasseries", "code": "brasseries"],
        ["name" : "Brazilian", "code": "brazilian"],
        ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
        ["name" : "British", "code": "british"],
        ["name" : "Buffets", "code": "buffets"],
        ["name" : "Bulgarian", "code": "bulgarian"],
        ["name" : "Burgers", "code": "burgers"],
        ["name" : "Burmese", "code": "burmese"],
        ["name" : "Cafes", "code": "cafes"],
        ["name" : "Cafeteria", "code": "cafeteria"],
        ["name" : "Cajun/Creole", "code": "cajun"],
        ["name" : "Cambodian", "code": "cambodian"],
        ["name" : "Canadian", "code": "New)"],
        ["name" : "Canteen", "code": "canteen"],
        ["name" : "Caribbean", "code": "caribbean"],
        ["name" : "Catalan", "code": "catalan"],
        ["name" : "Chech", "code": "chech"],
        ["name" : "Cheesesteaks", "code": "cheesesteaks"],
        ["name" : "Chicken Shop", "code": "chickenshop"],
        ["name" : "Chicken Wings", "code": "chicken_wings"],
        ["name" : "Chilean", "code": "chilean"],
        ["name" : "Chinese", "code": "chinese"],
        ["name" : "Comfort Food", "code": "comfortfood"],
        ["name" : "Corsican", "code": "corsican"],
        ["name" : "Creperies", "code": "creperies"],
        ["name" : "Cuban", "code": "cuban"],
        ["name" : "Curry Sausage", "code": "currysausage"],
        ["name" : "Cypriot", "code": "cypriot"],
        ["name" : "Czech", "code": "czech"],
        ["name" : "Czech/Slovakian", "code": "czechslovakian"],
        ["name" : "Danish", "code": "danish"],
        ["name" : "Delis", "code": "delis"],
        ["name" : "Diners", "code": "diners"],
        ["name" : "Dumplings", "code": "dumplings"],
        ["name" : "Eastern European", "code": "eastern_european"],
        ["name" : "Ethiopian", "code": "ethiopian"],
        ["name" : "Fast Food", "code": "hotdogs"],
        ["name" : "Filipino", "code": "filipino"],
        ["name" : "Fish & Chips", "code": "fishnchips"],
        ["name" : "Fondue", "code": "fondue"],
        ["name" : "Food Court", "code": "food_court"],
        ["name" : "Food Stands", "code": "foodstands"],
        ["name" : "French", "code": "french"],
        ["name" : "French Southwest", "code": "sud_ouest"],
        ["name" : "Galician", "code": "galician"],
        ["name" : "Gastropubs", "code": "gastropubs"],
        ["name" : "Georgian", "code": "georgian"],
        ["name" : "German", "code": "german"],
        ["name" : "Giblets", "code": "giblets"],
        ["name" : "Gluten-Free", "code": "gluten_free"],
        ["name" : "Greek", "code": "greek"],
        ["name" : "Halal", "code": "halal"],
        ["name" : "Hawaiian", "code": "hawaiian"],
        ["name" : "Heuriger", "code": "heuriger"],
        ["name" : "Himalayan/Nepalese", "code": "himalayan"],
        ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
        ["name" : "Hot Dogs", "code": "hotdog"],
        ["name" : "Hot Pot", "code": "hotpot"],
        ["name" : "Hungarian", "code": "hungarian"],
        ["name" : "Iberian", "code": "iberian"],
        ["name" : "Indian", "code": "indpak"],
        ["name" : "Indonesian", "code": "indonesian"],
        ["name" : "International", "code": "international"],
        ["name" : "Irish", "code": "irish"],
        ["name" : "Island Pub", "code": "island_pub"],
        ["name" : "Israeli", "code": "israeli"],
        ["name" : "Italian", "code": "italian"],
        ["name" : "Japanese", "code": "japanese"],
        ["name" : "Jewish", "code": "jewish"],
        ["name" : "Kebab", "code": "kebab"],
        ["name" : "Korean", "code": "korean"],
        ["name" : "Kosher", "code": "kosher"],
        ["name" : "Kurdish", "code": "kurdish"],
        ["name" : "Laos", "code": "laos"],
        ["name" : "Laotian", "code": "laotian"],
        ["name" : "Latin American", "code": "latin"],
        ["name" : "Live/Raw Food", "code": "raw_food"],
        ["name" : "Lyonnais", "code": "lyonnais"],
        ["name" : "Malaysian", "code": "malaysian"],
        ["name" : "Meatballs", "code": "meatballs"],
        ["name" : "Mediterranean", "code": "mediterranean"],
        ["name" : "Mexican", "code": "mexican"],
        ["name" : "Middle Eastern", "code": "mideastern"],
        ["name" : "Milk Bars", "code": "milkbars"],
        ["name" : "Modern Australian", "code": "modern_australian"],
        ["name" : "Modern European", "code": "modern_european"],
        ["name" : "Mongolian", "code": "mongolian"],
        ["name" : "Moroccan", "code": "moroccan"],
        ["name" : "New Zealand", "code": "newzealand"],
        ["name" : "Night Food", "code": "nightfood"],
        ["name" : "Norcinerie", "code": "norcinerie"],
        ["name" : "Open Sandwiches", "code": "opensandwiches"],
        ["name" : "Oriental", "code": "oriental"],
        ["name" : "Pakistani", "code": "pakistani"],
        ["name" : "Parent Cafes", "code": "eltern_cafes"],
        ["name" : "Parma", "code": "parma"],
        ["name" : "Persian/Iranian", "code": "persian"],
        ["name" : "Peruvian", "code": "peruvian"],
        ["name" : "Pita", "code": "pita"],
        ["name" : "Pizza", "code": "pizza"],
        ["name" : "Polish", "code": "polish"],
        ["name" : "Portuguese", "code": "portuguese"],
        ["name" : "Potatoes", "code": "potatoes"],
        ["name" : "Poutineries", "code": "poutineries"],
        ["name" : "Pub Food", "code": "pubfood"],
        ["name" : "Rice", "code": "riceshop"],
        ["name" : "Romanian", "code": "romanian"],
        ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
        ["name" : "Rumanian", "code": "rumanian"],
        ["name" : "Russian", "code": "russian"],
        ["name" : "Salad", "code": "salad"],
        ["name" : "Sandwiches", "code": "sandwiches"],
        ["name" : "Scandinavian", "code": "scandinavian"],
        ["name" : "Scottish", "code": "scottish"],
        ["name" : "Seafood", "code": "seafood"],
        ["name" : "Serbo Croatian", "code": "serbocroatian"],
        ["name" : "Signature Cuisine", "code": "signature_cuisine"],
        ["name" : "Singaporean", "code": "singaporean"],
        ["name" : "Slovakian", "code": "slovakian"],
        ["name" : "Soul Food", "code": "soulfood"],
        ["name" : "Soup", "code": "soup"],
        ["name" : "Southern", "code": "southern"],
        ["name" : "Spanish", "code": "spanish"],
        ["name" : "Steakhouses", "code": "steak"],
        ["name" : "Sushi Bars", "code": "sushi"],
        ["name" : "Swabian", "code": "swabian"],
        ["name" : "Swedish", "code": "swedish"],
        ["name" : "Swiss Food", "code": "swissfood"],
        ["name" : "Tabernas", "code": "tabernas"],
        ["name" : "Taiwanese", "code": "taiwanese"],
        ["name" : "Tapas Bars", "code": "tapas"],
        ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
        ["name" : "Tex-Mex", "code": "tex-mex"],
        ["name" : "Thai", "code": "thai"],
        ["name" : "Traditional Norwegian", "code": "norwegian"],
        ["name" : "Traditional Swedish", "code": "traditional_swedish"],
        ["name" : "Trattorie", "code": "trattorie"],
        ["name" : "Turkish", "code": "turkish"],
        ["name" : "Ukrainian", "code": "ukrainian"],
        ["name" : "Uzbek", "code": "uzbek"],
        ["name" : "Vegan", "code": "vegan"],
        ["name" : "Vegetarian", "code": "vegetarian"],
        ["name" : "Venison", "code": "venison"],
        ["name" : "Vietnamese", "code": "vietnamese"],
        ["name" : "Wok", "code": "wok"],
        ["name" : "Wraps", "code": "wraps"],
        ["name" : "Yugoslav", "code": "yugoslav"]]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Set the navigationBar colors.
        navigationController!.navigationBar.barTintColor = UIColor(red: CGFloat(Constants.YelpRed.Red), green: CGFloat(Constants.YelpRed.Green), blue: CGFloat(Constants.YelpRed.Blue), alpha: 1.0)
        navigationController!.navigationBar.tintColor = UIColor.white
        let titleDict = [NSForegroundColorAttributeName: UIColor.white as Any]
        navigationController!.navigationBar.titleTextAttributes = titleDict
        
        // Set up the tableView.
        tableView.estimatedRowHeight = 47
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    @IBAction func onCancelButton(_ sender: UIBarButtonItem)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearchButton(_ sender: UIBarButtonItem)
    {
        dismiss(animated: true, completion: nil)
        
        delegate?.filtersViewController(
            filtersViewController: self,
            didUpdateFilters: filters)
    }
    
}

// UITableView methods
extension FiltersViewController: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return Section.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        let section = Section(rawValue: section)!
        switch section
        {
        case Section.OfferingDeal:
            return nil
        case Section.Distance:
            return "Distance"
        case Section.SortBy:
            return "Sort by"
        case Section.Categories:
            return "Categories"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let section = Section(rawValue: section)!
        switch section
        {
        case Section.OfferingDeal:
            return 1
        case Section.Distance:
            return distanceComboBoxExpanded ? Distance.count : 1
        case Section.SortBy:
            return sortByComboBoxExpanded ? YelpSortMode.count : 1
        case Section.Categories:
            return categoriesExpanded ? categories.count : 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let section = Section(rawValue: indexPath.section)!
        switch section
        {
        case Section.OfferingDeal:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchTableViewCell
            
            // Set the cell contents.
            cell.setData(labelText: "Offering a Deal", isOn: filters.offeringDeal, delegate: self)
            
            return cell
        case Section.Distance:
            if distanceComboBoxExpanded
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CheckButtonCell") as! CheckButtonTableViewCell
                
                // Set the cell contents.
                if let distance = Distance(rawValue: indexPath.row)
                {
                    let isChecked = filters.distance == distance
                    cell.setData(labelText: distance.description, isChecked: isChecked, delegate: self)
                }
                
                return cell
            }
            else // not expanded
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ComboBoxCell") as! ComboBoxTableViewCell
                
                // Set the cell contents.
                cell.setData(labelText: filters.distance.description)
                
                return cell
            }
        case Section.SortBy:
            if sortByComboBoxExpanded
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CheckButtonCell") as! CheckButtonTableViewCell
                
                // Set the cell contents.
                if let sort = YelpSortMode(rawValue: indexPath.row)
                {
                    let isChecked = filters.sort == sort
                    cell.setData(labelText: sort.description, isChecked: isChecked, delegate: self)
                }
                
                return cell
            }
            else // not expanded
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ComboBoxCell") as! ComboBoxTableViewCell
                
                // Set the cell contents.
                cell.setData(labelText: filters.sort.description)
                
                return cell
            }
        case Section.Categories:
            if !categoriesExpanded && indexPath.row == 3
            {
                return tableView.dequeueReusableCell(withIdentifier: "SeeAllCell")!
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchTableViewCell
                
                // Set the cell contents.
                let category = categories[indexPath.row]
                let categoryName = category["name"]!
                let categoryCode = category["code"]!
                let isOn = filters.isCategoryDefined(category: categoryCode)
                cell.setData(labelText: categoryName, isOn: isOn, delegate: self)
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // If a combobox is expanded, selecting a row sets its filters
        // value and un-expands it. If a combobox is not expanded, selecting
        // the row expands it.
        let section = Section(rawValue: indexPath.section)!
        if section == Section.Distance
        {
            if distanceComboBoxExpanded
            {
                distanceComboBoxExpanded = false
                filters.distance = Distance(rawValue: indexPath.row)!
            }
            else // not expanded
            {
                distanceComboBoxExpanded = true
            }

            tableView.reloadSections(
                IndexSet(integer: indexPath.section),
                with: UITableViewRowAnimation.fade)
        }
        else if section == Section.SortBy
        {
            if sortByComboBoxExpanded
            {
                sortByComboBoxExpanded = false
                filters.sort = YelpSortMode(rawValue: indexPath.row)!
            }
            else // not expanded
            {
                sortByComboBoxExpanded = true
            }

            tableView.reloadSections(
                IndexSet(integer: indexPath.section),
                with: UITableViewRowAnimation.fade)
        }
        else if section == Section.Categories
        {
            // When the user clicks "See All", expand the categories.
            if !categoriesExpanded && indexPath.row == 3
            {
                categoriesExpanded = true

                tableView.reloadSections(
                    IndexSet(integer: indexPath.section),
                    with: UITableViewRowAnimation.fade)
            }
        }
    }
}

// SwitchTableViewCell methods
extension FiltersViewController: SwitchTableViewCellDelegate
{
    func switchTableViewCell(_ switchTableViewCell: SwitchTableViewCell, valueChanged isOn: Bool)
    {
        let indexPath = tableView.indexPath(for: switchTableViewCell)!
        let section = Section(rawValue: indexPath.section)!
        
        if section == Section.OfferingDeal
        {
            filters.offeringDeal = isOn
        }
        else if section == Section.Categories
        {
            if let categoryCode = categories[indexPath.row]["code"]
            {
                if isOn
                {
                    filters.addCategory(category: categoryCode)
                }
                else
                {
                    filters.removeCategory(category: categoryCode)
                }
            }
        }
    }
}

// CheckButtonTableViewCell methods
extension FiltersViewController: CheckButtonTableViewCellDelegate
{
    func checkButtonTableViewCell(_ checkButtonTableViewCell: CheckButtonTableViewCell, valueChanged isChecked: Bool)
    {
        let indexPath = tableView.indexPath(for: checkButtonTableViewCell)!
        let section = Section(rawValue: indexPath.section)!
 
        // When the value of the combobox changes, set its filters value and
        // un-expand it.
        if section == Section.Distance
        {
            distanceComboBoxExpanded = false
            
            let indexPath = tableView.indexPath(for: checkButtonTableViewCell)!
            filters.distance = Distance(rawValue: indexPath.row)!
            
            tableView.reloadSections(
                IndexSet(integer: indexPath.section),
                with: UITableViewRowAnimation.fade)
        }
        else if section == Section.SortBy
        {
            sortByComboBoxExpanded = false
            
            let indexPath = tableView.indexPath(for: checkButtonTableViewCell)!
            filters.sort = YelpSortMode(rawValue: indexPath.row)!
            
            tableView.reloadSections(
                IndexSet(integer: indexPath.section),
                with: UITableViewRowAnimation.fade)
        }
    }
}

