//
//  EditViewController.swift
//  MyHotels
//
//  Created by Bharath Raj Venkatesh on 28/04/22.
//

import UIKit

class EditViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var isEdit = false
    var editViewModel = EditViewModel()
    var selectedIndexPath: IndexPath?
    
    private let defaultIndexpath = IndexPath(row: 0, section: 0)
    private let defaultRating = 1
    
    private let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpView()
    }
    
    private func setUpView() {
        tableView.register(EditTableViewCell.nib(), forCellReuseIdentifier: EditTableViewCell.identifier)
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableView.automaticDimension
        
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        navigationItem.rightBarButtonItems = [save]
        navigationItem.title = isEdit ? Constants.General.editScreenTitle : Constants.General.addScreenTitle
        if isEdit {
            editViewModel.updateHotelCellViewModel()
        }
        
    }
    
    @objc private func saveTapped(_ sender: Any) {
        self.view.endEditing(true)
        
        if let cell = tableView.cellForRow(at: defaultIndexpath) as? EditTableViewCell,
           let name = cell.nameTextField.text,
           let address = cell.addressTextField.text,
           let dateOfStay = cell.dosTextField.text,
           let roomRate = cell.roomRateTextField.text,
           !name.isEmpty, !address.isEmpty, !dateOfStay.isEmpty, !roomRate.isEmpty {
            let roomRate = Double(roomRate)
            let rating = Int(cell.ratingValueLabel.text?.suffix(1) ?? "\(defaultRating)") ?? defaultRating
            let image = cell.photoImageView.image
            let isFavorite = (isEdit ? editViewModel.hotelModel?.isFavorite : false) ?? false
            let hotelModel = HotelModel(name: name,
                                        rating: rating,
                                        isFavorite: isFavorite,
                                        address: address,
                                        dateOfStay: dateOfStay,
                                        roomRate: roomRate,
                                        photo: image)
            guard let mainViewController = self.navigationController?.viewControllers.first as? ViewController else { return }
            if isEdit,
               let indexPath = selectedIndexPath {
                mainViewController.updateHotel(hotelModel: hotelModel, indexPath: indexPath)
            }
            else {
                mainViewController.addHotel(hotelModel: hotelModel)
            }
            self.navigationController?.popViewController(animated: true)
        }
        else {
            let alertController = UIAlertController(title: "Alert", message: "Please fill respective fields", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension EditViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editViewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: EditTableViewCell.identifier, for: indexPath) as? EditTableViewCell {
            if let hotelCellViewModel = editViewModel.hotelCellViewModel {
                cell.populate(hotelCellViewModel: hotelCellViewModel)
            }
            cell.choosePicureClosure = { [weak self] in
                guard let self = self else { return }
                self.presentImagePicker()
            }
            return cell
        }
        return UITableViewCell()
    }
    
    private func presentImagePicker() {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
    }
}

extension EditViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
           let cell = tableView.cellForRow(at: defaultIndexpath) as? EditTableViewCell {
            cell.populateImage(image: selectedImage)
        }
        dismiss(animated: true, completion: nil)
    }
}
