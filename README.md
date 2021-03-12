# ios-search-venue
Repo to demonstrate the Swift skills

## Version
1.0

## Build Requirements
- iOS 13.0+
- Xcode 11.0+

## Runtime Requirements
- iOS 13.0+

## Swift Version
- Swift 5.0

## Features

- [1] App uses device current location to fetch nearby venues.
- [2] A refresh button is provided at top left of navigation bar.

## About App

VenueSearch is a simple iOS application to:
- [1] Use public API of TabCorp to fetch nearby Venues from user's current location at specified Zoom level on the map. 
- [2] List the results in a UITableView
        a) title as Name of the Venue
        b) subtitle as Street, Suburb & PostCode
- [3] Refresh Button on the top left of the controller that refresh the list of venues accornding to user's current location.


## Application Architecture
This app follows MVVM Architecture with POP approach of the Swift Language.
This app is grouped into Model, View & ViewModel Xcode Groups. Each of these Xcode groups maps one-to-one with the section.

