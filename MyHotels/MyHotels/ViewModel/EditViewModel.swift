//
//  EditViewModel.swift
//  MyHotels
//
//  Created by Bharath Raj Venkatesh on 28/04/22.
//

import Foundation
import UIKit

protocol EditViewModelProtocol {
    func updateHotelCellViewModel()
}

class EditViewModel: EditViewModelProtocol {
    
    var hotelModel: HotelModel?
    var hotelCellViewModel: HotelCellViewModel?
    
    func updateHotelCellViewModel() {
        if let hotelModel = hotelModel {
            hotelCellViewModel = HotelCellViewModel(name: hotelModel.name,
                                                    rating: hotelModel.rating,
                                                    isFavorite: hotelModel.isFavorite,
                                                    address: hotelModel.address,
                                                    dateOfStay: hotelModel.dateOfStay,
                                                    roomRate: hotelModel.roomRate,
                                                    photo: hotelModel.photo)
        }
    }
}

struct HotelCellViewModel {
    let name: String
    let rating: Int
    let isFavorite: Bool
    let address: String
    let dateOfStay: String?
    let roomRate: Double?
    let photo: UIImage?
}
