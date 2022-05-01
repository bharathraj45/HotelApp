//
//  Extensions.swift
//  MyHotels
//
//  Created by Bharath Raj Venkatesh on 29/04/22.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {

    // Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
