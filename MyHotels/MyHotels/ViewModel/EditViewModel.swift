//
//  EditViewModel.swift
//  MyHotels
//
//  Created by Bharath Raj Venkatesh on 28/04/22.
//

import Foundation
import UIKit

protocol EditViewModelProtocol {
    func getNumberOfRows() -> Int
    func updateHotelCellViewModel()
}

class EditViewModel: EditViewModelProtocol {
    
    var hotelModel: HotelModel?
    var hotelCellViewModel: HotelCellViewModel?
    
    // MARK: - EditViewModelProtocol methods
    
    func getNumberOfRows() -> Int {
        return 1
    }
    
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
