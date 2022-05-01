//
//  HotelCellViewModel.swift
//  MyHotels
//
//  Created by Bharath Raj Venkatesh on 01/05/22.
//

import Foundation
import UIKit

struct HotelCellViewModel {
    let name: String
    let rating: Int
    let isFavorite: Bool
    let address: String
    let dateOfStay: String?
    let roomRate: Double?
    let photo: UIImage?
}
