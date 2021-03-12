//
//  VenueViewModel.swift
//  VenueSearch
//
//  Created by Ajay Sharma on 11/03/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation

typealias VenueCompletionHandler = (Result<[VenueCellViewModel], Error>) -> Void

class VenueViewModel {
    
    var venues = [VenueCellViewModel]()
    
    var coordinates: LocationCoordinates?
    let mapCoordinator = MapCoordinator()
    
    init(model: LocationCoordinates? = nil) {
        self.coordinates = model
    }
    
    /// Create Cell View Model
    /// - Parameter venues: List of venues
    func cellViewModel(venues: [Venue]) -> [VenueCellViewModel] {
        let cellVMs = venues.map {
            return VenueCellViewModel($0)
        }
        return cellVMs
    }
    
    func fetchVenue(completion: @escaping VenueCompletionHandler) {
        guard let cordinateModel = coordinates else {
            return
        }
        fetchVenues(coordinates: cordinateModel, completion: completion)
    }
    
    // MARK: - Fetch Venues -
    /// This method fetch near by venues based on user current location
    /// - Parameter completion: VenueCompletionHandler, This will contain result success with array of VenueCellViewModel and in case of failed to get near by venue it provide error
    private func fetchVenues(coordinates: LocationCoordinates, completion: @escaping VenueCompletionHandler)  {

        let parameters: KeyValuePairs = ["topLeftLat": "\(coordinates.topLeftLat)",
                                        "topLeftLon": "\(coordinates.topLeftLon)",
                                        "bottomRightLat": "\(coordinates.bottomRightLat)",
                                        "bottomRightLon": "\(coordinates.bottomRightLon)",
                                        "zoomLevel": "\(coordinates.zoomLevel)"]
        
        let venueProvider: VenueProvider = VenueDataController()
        venueProvider.venues(parameters: parameters, completion: {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let venueListModel):
                    debugPrint(venueListModel)
                    let cellVMs = self.cellViewModel(venues: venueListModel.venues)
                    completion(.success(cellVMs))
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        })
    }
}
