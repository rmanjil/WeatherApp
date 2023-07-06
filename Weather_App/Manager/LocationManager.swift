//
//  LocationManager.swift
//  Weather_App
//
//  Created by manjil on 05/07/2023.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
    private override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    var getParameter: [String: Any] {
        guard let location = LocationManager.shared.getCurrentLocation() else { return [:] }
        return ["lat":location.coordinate.latitude,
                         "lon": location.coordinate.longitude]
    }
    
    func isLocationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    func getCurrentLocation() -> CLLocation? {
        return self.currentLocation
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.currentLocation = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("authorizationStatus: \(manager.authorizationStatus)")
            switch manager.authorizationStatus {
            case .notDetermined:
                // Handle not determined state if needed
                break
            case .restricted, .denied:
                // Handle restricted or denied state
                break
            case .authorizedAlways, .authorizedWhenInUse:
                // Handle authorized state
                break
            @unknown default:
                // Handle other potential unknown states
                break
            }
        }
}
