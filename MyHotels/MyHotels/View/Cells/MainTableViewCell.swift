//
//  MainTableViewCell.swift
//  MyHotels
//
//  Created by Bharath Raj Venkatesh on 28/04/22.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let identifier = Constants.CellIdentifiers.mainCell
    
    static func nib() -> UINib {
        return UINib(nibName: Constants.CellIdentifiers.mainCell,
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
        self.favoriteButton.setImage(UIImage(named: Constants.Icons.favoriteUnSelected), for: .normal)
        self.favoriteButton.setImage(UIImage(named: Constants.Icons.favoriteSelected), for: .selected)
        self.ratingLabel.text = String(format: Constants.PlaceHolderTexts.rating, cellModel.rating)
        self.hotelImageView.image = (cellModel.photo != nil) ? cellModel.photo : UIImage(named: Constants.Icons.placeholder)
    }
    
    @IBAction func favoriteButtonTap(_ sender: UIButton) {
        favoriteTapClosure?(!sender.isSelected)
    }
}
