//
//  Venue.swift
//  VenueSearch
//
//  Created by Ajay Sharma on 11/03/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation

// Struct - VenueVM
struct VenueSearch: Codable {
    var venues: [Venue]
}

// Struct - Venue
struct Venue: Codable {
    var id: String
    var name: String
    var location: Location
    var venueType: String
    var street: String
    var suburb: String
    var status: String
    var postcode: Int
    var state: String
}

// Struct - Location
struct Location: Codable {
    var lat: Double
    var lon: Double
}

struct Bounds: Codable {
    var topLeft: TopLeft
    var bottomRight: BottomRight
}

struct TopLeft: Codable {
    var lat: Double
    var lon: Double
}

struct BottomRight: Codable {
    var lat: Double
    var lon: Double
}

// Struct - LocationCoordinates
struct LocationCoordinates: Codable {
    var topLeftLat: Double
    var topLeftLon: Double
    var bottomRightLat: Double
    var bottomRightLon: Double
    var zoomLevel: Float
}


