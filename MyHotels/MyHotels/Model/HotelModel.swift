//
//  HotelModel.swift
//  MyHotels
//
//  Created by Bharath Raj Venkatesh on 28/04/22.
//

import Foundation
import UIKit

struct HotelModel {
    let name: String
    let rating: Int
    var isFavorite: Bool
    let address: String
    let dateOfStay: String?
    let roomRate: Double?
    let photo: UIImage?
}
