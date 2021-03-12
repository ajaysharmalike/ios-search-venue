//
//  MapProvider.swift
//  VenueSearch
//
//  Created by Ajay Sharma on 11/03/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation
import MapKit

protocol MapProviderProtocol: AnyObject {
    func mapCoordinates(didReceiveCoordinates model: LocationCoordinates?)
}

class MapCoordinator: NSObject {
    private var mapView: MKMapView?
    private let locationService = LocationService()
    
    weak var delegate: MapProviderProtocol?
    
    /// Configure MapView
    func configureMapView() {
        mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView?.showsUserLocation = true
        mapView?.delegate = self
    }
    
    func getCurrentLocation() {
        locationService.getCurrentLocation {[weak self] (location) in
            self?.setMapViewRegionWith(currentLocation: location)
        }
    }
    
    /// Set Map Region
    /// - Parameter location: current location from Location Manager
    private func setMapViewRegionWith(currentLocation location: CLLocation?) {
        let center = CLLocationCoordinate2D(latitude: location?.coordinate.latitude ?? 0, longitude: location?.coordinate.longitude ?? 0)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView?.setRegion(region, animated: true)
    }
}

// MARK: - MKMapViewDelegate Delegate -
extension MapCoordinator: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let topLeftCoordinate = mapView.convert(.zero, toCoordinateFrom: mapView)
        let bottomRightCoordinate = mapView.convert(CGPoint(x: mapView.bounds.size.width, y: mapView.bounds.size.height), toCoordinateFrom: mapView)
        
        //Create Model
        let mapInfoModel = LocationCoordinates(topLeftLat: topLeftCoordinate.latitude, topLeftLon: topLeftCoordinate.longitude, bottomRightLat: bottomRightCoordinate.latitude, bottomRightLon: bottomRightCoordinate.longitude, zoomLevel: getZoomLevel(with: mapView))
        
        delegate?.mapCoordinates(didReceiveCoordinates: mapInfoModel)
    }
    
    private func getZoomLevel(with mapView: MKMapView) -> Float {
        return Float(log2(360 * (Double(mapView.bounds.size.width/256) / mapView.region.span.longitudeDelta)) + 1)
    }
}
