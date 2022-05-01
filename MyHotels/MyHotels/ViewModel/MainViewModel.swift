//
//  MainViewModel.swift
//  MyHotels
//
//  Created by Bharath Raj Venkatesh on 28/04/22.
//

import Foundation
import UIKit

protocol MainViewModelProtocol {
    func getNumberOfRows() -> Int
    func getMainCellModel(row: Int) -> MainCellModel?
    func updateFavorite(isSelected: Bool, row: Int)
    func addHotel(hotel: HotelModel)
    func updateHotel(hotel: HotelModel, row: Int)
    func deleteHotel(row: Int)
}

class MainViewModel: MainViewModelProtocol {
    
    var hotels: [HotelModel] = []
    var mainCellModel: MainCellModel?
    
    var reloadTableView: (() -> Void)?
    
    // MARK: - MainViewModelProtocol methods
    
    func getNumberOfRows() -> Int {
        return hotels.count
    }
    
    func getMainCellModel(row: Int) -> MainCellModel? {
        if let hotel = hotels[safe: row] {
            return MainCellModel(name: hotel.name, rating: hotel.rating, isFavorite: hotel.isFavorite, photo: hotel.photo)
        }
        return nil
    }
    
    func updateFavorite(isSelected: Bool, row: Int) {
        if var hotel = hotels[safe: row] {
            hotel.isFavorite = isSelected
            hotels[row] = hotel
            reloadTableView?()
        }
    }
    
    func addHotel(hotel: HotelModel) {
        hotels.append(hotel)
        reloadTableView?()
    }
    
    func updateHotel(hotel: HotelModel, row: Int) {
        hotels[row] = hotel
        reloadTableView?()
    }
    
    func deleteHotel(row: Int) {
        hotels.remove(at: row)
        reloadTableView?()
    }
}
