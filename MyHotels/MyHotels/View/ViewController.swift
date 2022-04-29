//
//  ViewController.swift
//  MyHotels
//
//  Created by Bharath Raj Venkatesh on 28/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mainViewModel: MainViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
    }
    
    private func setUp() {
        tableView.register(MainTableViewCell.nib(), forCellReuseIdentifier: MainTableViewCell.identifier)
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationItem.title = "My Hotels"
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [add]
        
        mainViewModel = MainViewModel()
        mainViewModel?.reloadTableView = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    func addHotel(hotelModel: HotelModel) {
        mainViewModel?.addHotel(hotel: hotelModel)
    }
    
    func updateHotel(hotelModel: HotelModel, indexPath: IndexPath) {
        mainViewModel?.updateHotel(hotel: hotelModel, row: indexPath.row)
    }
    
    @objc private func addTapped(_ sender: Any) {
        self.performSegue(withIdentifier: Constants.editViewControllerSegue, sender: sender)
    }
    
     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == Constants.editViewControllerSegue,
            let editViewcontroller = segue.destination as?  EditViewController {
             if !(sender is UIBarItem),
                let indexPath = tableView.indexPathForSelectedRow,
                let hotelModel = mainViewModel?.hotels[indexPath.row] {
                 editViewcontroller.editViewModel.hotelModel = hotelModel
                 editViewcontroller.isEdit = true
                 editViewcontroller.selectedIndexPath = indexPath
             }
         }
     }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  mainViewModel?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell,
           let mainCellModel = mainViewModel?.getMainCellModel(row: indexPath.row) {
            cell.populate(cellModel: mainCellModel)
            cell.favoriteTapClosure = { [weak self] (isSelected) in
                guard let self = self else { return }
                self.mainViewModel?.updateFavorite(isSelected: isSelected, row: indexPath.row)
            }
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.editViewControllerSegue, sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.mainViewModel?.deleteHotel(row: indexPath.row)
        }
    }
}
