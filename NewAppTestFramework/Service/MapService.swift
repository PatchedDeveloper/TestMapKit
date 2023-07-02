//
//  MapService.swift
//  NewAppTestFramework
//
//  Created by Danila Kardashevkii on 02.07.2023.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
    @EnvironmentObject var mapData : MapViewModel
    
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
     
        let view = mapData.mapView
        
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        return view
        
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {

    }
    
    class Coordinator : NSObject,MKMapViewDelegate{
        
    }
}
