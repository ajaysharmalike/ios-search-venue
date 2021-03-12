//
//  VSConstants.swift
//  VenueSearch
//
//  Created by Ajay Sharma on 11/03/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation

enum AppConstants : String{
    case title = "Venues"
    case noVenues = "No Venues nearby"
    case ok = "OK"
    case refresh = "Refresh"
    case success = "Success"
    case errorMessage = "Some error occurred, Please try again!"
    case invalidURL = "Invalid URL"
}

enum LocationConstants : String {
    case permissionDenied = "Permission Denied"
    case permissionMessage = "Please allow permission"
    case locationDisabledMessage = "Location Services disabled"
    case locationEnableMessage = "Please enable Location Services in Settings"
}

let venueURL = "https://uat02.beta.tab.com.au/v1/invenue-service/public-venue-search"
