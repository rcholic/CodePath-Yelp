//
//  YelpFilters.swift
//  Yelp
//
//  Created by Guoliang Wang on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import Foundation

final class YelpFilters: NSObject {
    
    internal var filters: [Filter]
    
//    public static let shared = YelpFilters()
    
    override init() {
        
        filters = [
            Filter(
                label: "",
                code: "deals_filter",
                type: FilterType.single,
                numItemsVisible: 1,
                options: [
                    Option(label: "Offering a Deal", value: "deals_filter", isSelected: false)
                ],
                allowMultiSelect: false,
                isCollapsed: false,
                cellType: .switchCell),
            
            Filter(label: "Distance",
                   code: "radius_filter",
                   type: FilterType.dropDown,
                   numItemsVisible: 0,
                   options: [
                        Option(label: "Auto", value: "", isSelected: true),
                        Option(label: "1 Mile", value: "1609", isSelected: false),
                        Option(label: "2 Miles", value: "3618", isSelected: false),
                        Option(label: "5 Mile", value: "8045", isSelected: false),
                        Option(label: "10 Mile", value: "16090", isSelected: false),
                        Option(label: "25 Mile", value: "40000", isSelected: false)
                    ],
                   allowMultiSelect: false,
                   isCollapsed: true,
                   cellType: .optionCell),
            
            Filter(label: "Sort by",
                   code: "sort",
                   type: FilterType.dropDown,
                   numItemsVisible: 1,
                   options: [
                    Option(label: "Best Match", value: YelpSortMode.bestMatched.rawValue.description, isSelected: true),
                    Option(label: "Distance", value: YelpSortMode.distance.rawValue.description, isSelected: false),
                    Option(label: "Rating", value: YelpSortMode.highestRated.rawValue.description, isSelected: false)
                ],
                   allowMultiSelect: false,
                   isCollapsed: true,
                   cellType: .optionCell),
            
            Filter(label: "Categories",
                   code: "category_filter",
                   type: FilterType.list,
                   numItemsVisible: nil, // show all
                   options: [
                    Option(label: "Afghan", value: "afghani", isSelected: false),
                    Option(label: "African", value: "african", isSelected: false),
                    Option(label: "American, New", value: "newamerican", isSelected: false),
                    Option(label: "American, Traditional", value: "tradamerican", isSelected: false),
                    Option(label: "Arabian", value: "arabian", isSelected: false),
                    Option(label: "Argentine", value: "argentine", isSelected: false),
                    Option(label: "Armenian", value: "armenian", isSelected: false),
                    Option(label: "Asian Fusion", value: "asianfusion", isSelected: false),
                    Option(label: "Asturian", value: "asturian", isSelected: false),
                    Option(label: "Australian", value: "australian", isSelected: false),
                    Option(label: "Austrian", value: "austrian", isSelected: false),
                    Option(label: "Baguettes", value: "baguettes", isSelected: false),
                    Option(label: "Bangladeshi", value: "bangladeshi", isSelected: false),
                    Option(label: "Barbeque", value: "bbq", isSelected: false),
                    Option(label: "Basque", value: "basque", isSelected: false),
                    Option(label: "Bavarian", value: "bavarian", isSelected: false),
                    Option(label: "Beer Garden", value: "beergarden", isSelected: false),
                    Option(label: "Beer Hall", value: "beerhall", isSelected: false),
                    Option(label: "Beisl", value: "beisl", isSelected: false),
                    Option(label: "Belgian", value: "belgian", isSelected: false),
                    Option(label: "Bistros", value: "bistros", isSelected: false),
                    Option(label: "Black Sea", value: "blacksea", isSelected: false),
                    Option(label: "Brasseries", value: "brasseries", isSelected: false),
                    Option(label: "Brazilian", value: "brazilian", isSelected: false),
                    Option(label: "Breakfast & Brunch", value: "breakfast_brunch", isSelected: false),
                    Option(label: "British", value: "british", isSelected: false),
                    Option(label: "Buffets", value: "buffets", isSelected: false),
                    Option(label: "Bulgarian", value: "bulgarian", isSelected: false),
                    Option(label: "Burgers", value: "burgers", isSelected: false),
                    Option(label: "Burmese", value: "burmese", isSelected: false),
                    Option(label: "Cafes", value: "cafes", isSelected: false),
                    Option(label: "Cafeteria", value: "cafeteria", isSelected: false),
                    Option(label: "Cajun/Creole", value: "cajun", isSelected: false),
                    Option(label: "Cambodian", value: "cambodian", isSelected: false),
                    Option(label: "Canadian", value: "New)", isSelected: false),
                    Option(label: "Canteen", value: "canteen", isSelected: false),
                    Option(label: "Caribbean", value: "caribbean", isSelected: false),
                    Option(label: "Catalan", value: "catalan", isSelected: false),
                    Option(label: "Chech", value: "chech", isSelected: false),
                    Option(label: "Cheesesteaks", value: "cheesesteaks", isSelected: false),
                    Option(label: "Chicken Shop", value: "chickenshop", isSelected: false),
                    Option(label: "Chicken Wings", value: "chicken_wings", isSelected: false),
                    Option(label: "Chilean", value: "chilean", isSelected: false),
                    Option(label: "Chinese", value: "chinese", isSelected: true),
                    Option(label: "Comfort Food", value: "comfortfood", isSelected: false),
                    Option(label: "Corsican", value: "corsican", isSelected: false),
                    Option(label: "Creperies", value: "creperies", isSelected: false),
                    Option(label: "Cuban", value: "cuban", isSelected: false),
                    Option(label: "Curry Sausage", value: "currysausage", isSelected: false),
                    Option(label: "Cypriot", value: "cypriot", isSelected: false),
                    Option(label: "Czech", value: "czech", isSelected: false),
                    Option(label: "Czech/Slovakian", value: "czechslovakian", isSelected: false),
                    Option(label: "Danish", value: "danish", isSelected: false),
                    Option(label: "Delis", value: "delis", isSelected: false),
                    Option(label: "Diners", value: "diners", isSelected: false),
                    Option(label: "Dumplings", value: "dumplings", isSelected: false),
                    Option(label: "Eastern European", value: "eastern_european", isSelected: false),
                    Option(label: "Ethiopian", value: "ethiopian", isSelected: false),
                    Option(label: "Fast Food", value: "hotdogs", isSelected: false),
                    Option(label: "Filipino", value: "filipino", isSelected: false),
                    Option(label: "Fish & Chips", value: "fishnchips", isSelected: false),
                    Option(label: "Fondue", value: "fondue", isSelected: false),
                    Option(label: "Food Court", value: "food_court", isSelected: false),
                    Option(label: "Food Stands", value: "foodstands", isSelected: false),
                    Option(label: "French", value: "french", isSelected: false),
                    Option(label: "French Southwest", value: "sud_ouest", isSelected: false),
                    Option(label: "Galician", value: "galician", isSelected: false),
                    Option(label: "Gastropubs", value: "gastropubs", isSelected: false),
                    Option(label: "Georgian", value: "georgian", isSelected: false),
                    Option(label: "German", value: "german", isSelected: false),
                    Option(label: "Giblets", value: "giblets", isSelected: false),
                    Option(label: "Gluten-Free", value: "gluten_free", isSelected: false),
                    Option(label: "Greek", value: "greek", isSelected: false),
                    Option(label: "Halal", value: "halal", isSelected: false),
                    Option(label: "Hawaiian", value: "hawaiian", isSelected: false),
                    Option(label: "Heuriger", value: "heuriger", isSelected: false),
                    Option(label: "Himalayan/Nepalese", value: "himalayan", isSelected: false),
                    Option(label: "Hong Kong Style Cafe", value: "hkcafe", isSelected: false),
                    Option(label: "Hot Dogs", value: "hotdog", isSelected: false),
                    Option(label: "Hot Pot", value: "hotpot", isSelected: false),
                    Option(label: "Hungarian", value: "hungarian", isSelected: false),
                    Option(label: "Iberian", value: "iberian", isSelected: false),
                    Option(label: "Indian", value: "indpak", isSelected: false),
                    Option(label: "Indonesian", value: "indonesian", isSelected: false),
                    Option(label: "International", value: "international", isSelected: false),
                    Option(label: "Irish", value: "irish", isSelected: false),
                    Option(label: "Island Pub", value: "island_pub", isSelected: false),
                    Option(label: "Israeli", value: "israeli", isSelected: false),
                    Option(label: "Italian", value: "italian", isSelected: false),
                    Option(label: "Japanese", value: "japanese", isSelected: false),
                    Option(label: "Jewish", value: "jewish", isSelected: false),
                    Option(label: "Kebab", value: "kebab", isSelected: false),
                    Option(label: "Korean", value: "korean", isSelected: false),
                    Option(label: "Kosher", value: "kosher", isSelected: false),
                    Option(label: "Kurdish", value: "kurdish", isSelected: false),
                    Option(label: "Laos", value: "laos", isSelected: false),
                    Option(label: "Laotian", value: "laotian", isSelected: false),
                    Option(label: "Latin American", value: "latin", isSelected: false),
                    Option(label: "Live/Raw Food", value: "raw_food", isSelected: false),
                    Option(label: "Lyonnais", value: "lyonnais", isSelected: false),
                    Option(label: "Malaysian", value: "malaysian", isSelected: false),
                    Option(label: "Meatballs", value: "meatballs", isSelected: false),
                    Option(label: "Mediterranean", value: "mediterranean", isSelected: false),
                    Option(label: "Mexican", value: "mexican", isSelected: false),
                    Option(label: "Middle Eastern", value: "mideastern", isSelected: false),
                    Option(label: "Milk Bars", value: "milkbars", isSelected: false),
                    Option(label: "Modern Australian", value: "modern_australian", isSelected: false),
                    Option(label: "Modern European", value: "modern_european", isSelected: false),
                    Option(label: "Mongolian", value: "mongolian", isSelected: false),
                    Option(label: "Moroccan", value: "moroccan", isSelected: false),
                    Option(label: "New Zealand", value: "newzealand", isSelected: false),
                    Option(label: "Night Food", value: "nightfood", isSelected: false),
                    Option(label: "Norcinerie", value: "norcinerie", isSelected: false),
                    Option(label: "Open Sandwiches", value: "opensandwiches", isSelected: false),
                    Option(label: "Oriental", value: "oriental", isSelected: false),
                    Option(label: "Pakistani", value: "pakistani", isSelected: false),
                    Option(label: "Parent Cafes", value: "eltern_cafes", isSelected: false),
                    Option(label: "Parma", value: "parma", isSelected: false),
                    Option(label: "Persian/Iranian", value: "persian", isSelected: false),
                    Option(label: "Peruvian", value: "peruvian", isSelected: false),
                    Option(label: "Pita", value: "pita", isSelected: false),
                    Option(label: "Pizza", value: "pizza", isSelected: false),
                    Option(label: "Polish", value: "polish", isSelected: false),
                    Option(label: "Portuguese", value: "portuguese", isSelected: false),
                    Option(label: "Potatoes", value: "potatoes", isSelected: false),
                    Option(label: "Poutineries", value: "poutineries", isSelected: false),
                    Option(label: "Pub Food", value: "pubfood", isSelected: false),
                    Option(label: "Rice", value: "riceshop", isSelected: false),
                    Option(label: "Romanian", value: "romanian", isSelected: false),
                    Option(label: "Rotisserie Chicken", value: "rotisserie_chicken", isSelected: false),
                    Option(label: "Rumanian", value: "rumanian", isSelected: false),
                    Option(label: "Russian", value: "russian", isSelected: false),
                    Option(label: "Salad", value: "salad", isSelected: false),
                    Option(label: "Sandwiches", value: "sandwiches", isSelected: false),
                    Option(label: "Scandinavian", value: "scandinavian", isSelected: false),
                    Option(label: "Scottish", value: "scottish", isSelected: false),
                    Option(label: "Seafood", value: "seafood", isSelected: false),
                    Option(label: "Serbo Croatian", value: "serbocroatian", isSelected: false),
                    Option(label: "Signature Cuisine", value: "signature_cuisine", isSelected: false),
                    Option(label: "Singaporean", value: "singaporean", isSelected: false),
                    Option(label: "Slovakian", value: "slovakian", isSelected: false),
                    Option(label: "Soul Food", value: "soulfood", isSelected: false),
                    Option(label: "Soup", value: "soup", isSelected: false),
                    Option(label: "Southern", value: "southern", isSelected: false),
                    Option(label: "Spanish", value: "spanish", isSelected: false),
                    Option(label: "Steakhouses", value: "steak", isSelected: false),
                    Option(label: "Sushi Bars", value: "sushi", isSelected: false),
                    Option(label: "Swabian", value: "swabian", isSelected: false),
                    Option(label: "Swedish", value: "swedish", isSelected: false),
                    Option(label: "Swiss Food", value: "swissfood", isSelected: false),
                    Option(label: "Tabernas", value: "tabernas", isSelected: false),
                    Option(label: "Taiwanese", value: "taiwanese", isSelected: false),
                    Option(label: "Tapas Bars", value: "tapas", isSelected: false),
                    Option(label: "Tapas/Small Plates", value: "tapasmallplates", isSelected: false),
                    Option(label: "Tex-Mex", value: "tex-mex", isSelected: false),
                    Option(label: "Thai", value: "thai", isSelected: false),
                    Option(label: "Traditional Norwegian", value: "norwegian", isSelected: false),
                    Option(label: "Traditional Swedish", value: "traditional_swedish", isSelected: false),
                    Option(label: "Trattorie", value: "trattorie", isSelected: false),
                    Option(label: "Turkish", value: "turkish", isSelected: false),
                    Option(label: "Ukrainian", value: "ukrainian", isSelected: false),
                    Option(label: "Uzbek", value: "uzbek", isSelected: false),
                    Option(label: "Vegan", value: "vegan", isSelected: false),
                    Option(label: "Vegetarian", value: "vegetarian", isSelected: false),
                    Option(label: "Venison", value: "venison", isSelected: false),
                    Option(label: "Vietnamese", value: "vietnamese", isSelected: false),
                    Option(label: "Wok", value: "wok", isSelected: false),
                    Option(label: "Wraps", value: "wraps", isSelected: false),
                    Option(label: "Yugoslav", value: "yugoslav", isSelected: false)
                    ],
                   allowMultiSelect: true,
                   isCollapsed: true)
        ]
        super.init()
    }
    
    internal var parameters: [String : AnyObject] {
        get {
            var params: [String : AnyObject] = [:]
            
            for (_, filter) in self.filters.enumerated() {
                if filter.code == "deals_filter" {
                    params[filter.code] = filter.options[0].isSelected as AnyObject?
                } else if filter.code == "sort" {
                    var sortMode: Int = 0 // integer required for "sort" parameter
                    if let sortModelStr = filter.options.first(where: { (op: Option) -> Bool in
                        return op.isSelected
                    }) {
                        sortMode = Int(sortModelStr.value) ?? 0
                    }
                    params[filter.code] = sortMode as AnyObject
                } else {
                    let selectedOptions = filter.getSelectedOptions()
                    let optionValues: [String] = selectedOptions.map {
                        return $0.value
                    }

                    if filter.code == "radius_filter" {
                        // number required for radius_filter
                        let radius = Int(optionValues[0]) ?? 3218
                        params[filter.code] = radius as AnyObject
                        
                    } else {
                        let joinedValues = optionValues.joined(separator: ",")
                        params[filter.code] = joinedValues as AnyObject
                    }

                }
            }
            
            return params
        }
    }
    
}
