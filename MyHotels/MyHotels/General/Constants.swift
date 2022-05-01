//
//  Constants.swift
//  MyHotels
//
//  Created by Bharath Raj Venkatesh on 28/04/22.
//

import Foundation

struct Constants {
    
    struct SegueIdentifiers {
        static let editViewControllerSegue = "EditViewController"
    }
    
    struct DateFormats {
        static let dayMonthYear = "dd MMM yyyy"
    }
    
    struct General {
        static let mainScreenTitle = "My Hotels"
        static let addScreenTitle = "Add Hotel"
        static let editScreenTitle = "Edit Hotel"
    }
    
    struct Icons {
        static let favoriteSelected = "favorite_selected"
        static let favoriteUnSelected = "favorite_unselected"
        static let placeholder = "placeholder"
    }
    
    struct PlaceHolderTexts {
        static let rating = "Rating %d/5"
    }
    
    struct CellIdentifiers {
        static let mainCell = "MainTableViewCell"
        static let editCell = "EditTableViewCell"
    }
}
