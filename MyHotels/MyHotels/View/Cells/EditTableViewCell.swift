//
//  EditTableViewCell.swift
//  MyHotels
//
//  Created by Bharath Raj Venkatesh on 28/04/22.
//

import UIKit

class EditTableViewCell: UITableViewCell {
    
    static let identifier = "EditTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "EditTableViewCell",
                     bundle: nil)
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var dosTextField: UITextField!
    @IBOutlet weak var roomRateTextField: UITextField!
    @IBOutlet weak var ratingStepper: UIStepper!
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @objc var choosePicureClosure: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ratingStepper.minimumValue = 1.0
        ratingStepper.maximumValue = 5.0
        
        let datePickerView = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 200))
        datePickerView.datePickerMode = .date
        datePickerView.preferredDatePickerStyle = .wheels
        dosTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(choosePicture))
        tap.numberOfTapsRequired = 1
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(tap)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
    }
    
    func populate(hotelCellViewModel: HotelCellViewModel) {
        nameTextField.text = hotelCellViewModel.name
        addressTextField.text = hotelCellViewModel.address
        dosTextField.text = hotelCellViewModel.dateOfStay
        roomRateTextField.text = hotelCellViewModel.roomRate?.description
        ratingValueLabel.text = "Rating \(hotelCellViewModel.rating)"
        ratingStepper.value = Double(hotelCellViewModel.rating)
        photoImageView.image = (hotelCellViewModel.photo != nil) ? hotelCellViewModel.photo : UIImage(named: "placeholder")
    }
    
    func populateImage(image: UIImage) {
        self.photoImageView.image = image
    }
    
    @IBAction func stepperTap(_ sender: UIStepper) {
        ratingValueLabel.text = "Rating \(Int(sender.value).description)"
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        dosTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func choosePicture() {
        self.choosePicureClosure?()
    }
}

extension EditTableViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
