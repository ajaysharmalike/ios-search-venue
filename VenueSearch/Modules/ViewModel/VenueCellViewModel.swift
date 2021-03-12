//
//  VenueCellViewModel.swift
//  VenueSearch
//
//  Created by Ajay Sharma on 11/03/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation

protocol VenueRepresentable {
    var title: String? { get }
    var subtitle: String? { get }
}

class VenueCellViewModel: NSObject, VenueRepresentable {
    
    let venue: Venue
    
    var subtitle: String? {
        return venue.street + ", " + venue.suburb + ", " + "\(venue.postcode)"
    }

    var title: String? {
        return venue.name
    }
    
    init(_ venue: Venue) {
        self.venue = venue
    }
}
