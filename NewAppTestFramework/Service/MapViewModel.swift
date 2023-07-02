//
//  SwiftUIView.swift
//  NewAppTestFramework
//
//  Created by Danila Kardashevkii on 02.07.2023.
//

import SwiftUI
import MapKit
import CoreLocation

class MapViewModel: NSObject,ObservableObject,CLLocationManagerDelegate{
    
    @Published var mapView = MKMapView()
    
    //Region...
    @Published var region : MKCoordinateRegion!
    
    //Permission...
    @Published var permissionDenied = false
    
    //MapType
    @Published var mapType: MKMapType = .mutedStandard
    //update maptype
    
    func updateMapType(){
        if mapType == .mutedStandard{
            mapType = .hybridFlyover
            mapView.mapType = mapType
        }
        else{
            mapType = .mutedStandard
            mapView.mapType = mapType
        }
    }
    
    //focus location...
    
    func focusLocation(){
        guard let _ = region else {return}
        
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus{
            case .denied:
            //Alert...
            permissionDenied.toggle()
            
            case .notDetermined:
            manager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse:
            manager.requestLocation()
            
        default:
            ()
        }
    }
     
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Error...
        print(error.localizedDescription)
    }
    
    // getting user region
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {return}
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        //updateMap...
        
        self.mapView.setRegion(self.region, animated: true)
        
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true )
    }
}
