//
//  VenueSearchVC.swift
//  VenueSearch
//
//  Created by Ajay Sharma on 10/03/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class VenueSearchViewController: UIViewController {

    // MARK: - IBOutlet -
    @IBOutlet weak var venueTableView: UITableView!
    @IBOutlet weak var refreshBarButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties -
    let mapCoordinator = MapCoordinator()
    
    var viewModel = VenueViewModel()
    
    var venues = [VenueCellViewModel]() {
        didSet {
            venueTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureMapCoordinator()
    }
}

// MARK: - ViewController functions
extension VenueSearchViewController {
    
    private func configureUI() {
        self.title = AppConstants.title.rawValue
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: AppConstants.refresh.rawValue, style: .plain, target: self, action: #selector(VenueSearchViewController.getVenueList))
    }
    
    @objc
    fileprivate func getVenueList() {
        viewModel.fetchVenue{ [weak self] (result) in
            switch result {
            case .success(let venues):
                self?.refreshData(venueList: venues)
            case .failure(let error):
                self?.showMessage(message: error.localizedDescription)
            }
        }
    }
    
    /// This method show tha updated data on table view if data is not available it will show an alert message
    /// - Parameter venueList: array of VenueCellViewModel which updated with data source to show latest data
    private func refreshData(venueList: [VenueCellViewModel]) {
        guard venueList.count > 0 else {
            return showMessage(message: AppConstants.noVenues.rawValue)
        }
        viewModel.venues = venueList
        venueTableView.reloadData()
    }
}

// MARK: - TableView Datasource & Delegate Source
extension VenueSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = venues[indexPath.row].title
        cell.detailTextLabel?.text = venues[indexPath.row].subtitle
        return cell
    }
    
}

// MARK: - MapCoordinatorDelegate
extension VenueSearchViewController: MapProviderProtocol {
    
    private func configureMapCoordinator() {
        mapCoordinator.configureMapView()
        mapCoordinator.delegate = self
        mapCoordinator.getCurrentLocation()
    }
    
    func mapCoordinates(didReceiveCoordinates model: LocationCoordinates?) {
        viewModel.coordinates = model
        getVenueList()
    }
}

// MARK: - AlertProtocol
extension VenueSearchViewController : AlertProtocol {
    
     /// This method will show an alert with specified message
       /// - Parameter message: this is the message which we need to show on alert
    private func showMessage(message: String?) {
        showAlert(title: self.title, message: message, actionTexts: ["OK"], completion: nil)
    }
}

