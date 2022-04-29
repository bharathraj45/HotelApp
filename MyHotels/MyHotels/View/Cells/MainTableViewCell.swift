//
//  MainTableViewCell.swift
//  MyHotels
//
//  Created by Bharath Raj Venkatesh on 28/04/22.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let identifier = "MainTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "MainTableViewCell",
                     bundle: nil)
    }
    
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favoriteTapClosure: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.hotelImageView.image = nil
    }
    
    func populate(cellModel: MainCellModel) {
        self.hotelImageView.image = cellModel.photo
        self.hotelNameLabel.text = cellModel.name
        self.favoriteButton.isSelected = cellModel.isFavorite
        self.favoriteButton.setImage(UIImage(named: "favorite_unselected"), for: .normal)
        self.favoriteButton.setImage(UIImage(named: "favorite_selected"), for: .selected)
        self.ratingLabel.text = "Rating \(cellModel.rating)/5"
        self.hotelImageView.image = (cellModel.photo != nil) ? cellModel.photo : UIImage(named: "placeholder")
    }
    
    @IBAction func favoriteButtonTap(_ sender: UIButton) {
        favoriteTapClosure?(!sender.isSelected)
    }
}
