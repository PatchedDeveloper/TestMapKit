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
    @EnvironmentObject var mapData: MapViewModel
    var onDistanceUpdated: ((Double) -> Void)?
    func makeCoordinator() -> Coordinator {
        return Coordinator(mapData: mapData)
    }

    func makeUIView(context: Context) -> MKMapView {
        let view = mapData.mapView

        view.showsUserLocation = true
        view.delegate = context.coordinator

        // Добавляем жест для зажатия пальца на карту
        let longPressGesture = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleLongPress(_:)))
        view.addGestureRecognizer(longPressGesture)

        return view
    }

    func updateUIView(_ view: MKMapView, context: Context) {
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var mapData: MapViewModel
        var previousMarker: MKPointAnnotation?
        var onDistanceUpdated: ((Double) -> Void)? // Предыдущая метка
        
        init(mapData: MapViewModel) {
            self.mapData = mapData
        }
        
        @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
            if gestureRecognizer.state == .began {
                let mapView = gestureRecognizer.view as! MKMapView
                let touchPoint = gestureRecognizer.location(in: mapView)
                let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
                
                // Удаляем предыдущую метку
                if let previousMarker = previousMarker {
                    mapView.removeAnnotation(previousMarker)
                }
                
                // Создаем новую метку с использованием координат
                let marker = MKPointAnnotation()
                marker.coordinate = coordinate
                marker.title = "Новая метка"
                
                // Добавляем новую метку на карту
                mapView.addAnnotation(marker)
                
                // Сохраняем новую метку как предыдущую
                previousMarker = marker
                
                // Обрисовываем маршрут
                drawRoute(from: mapView.userLocation.coordinate, to: coordinate, on: mapView)
            }
        }
        
        func drawRoute(from sourceCoordinate: CLLocationCoordinate2D, to destinationCoordinate: CLLocationCoordinate2D, on mapView: MKMapView) {
            let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
            let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            let request = MKDirections.Request()
            request.source = sourceMapItem
            request.destination = destinationMapItem
            request.transportType = .automobile
            
            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                guard let route = response?.routes.first else { return }
                
                // Удаление предыдущего маршрута, если есть
                if let overlays = mapView.overlays as? [MKPolyline] {
                    mapView.removeOverlays(overlays)
                }
                
                // Обрисовка нового маршрута
                mapView.addOverlay(route.polyline)
                
                // Определение видимой области карты, чтобы включить весь маршрут
                let rect = route.polyline.boundingMapRect
                mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
            
            let sourceLocation = CLLocation(latitude: sourceCoordinate.latitude, longitude: sourceCoordinate.longitude)
               let destinationLocation = CLLocation(latitude: destinationCoordinate.latitude, longitude: destinationCoordinate.longitude)
               
               let distance = sourceLocation.distance(from: destinationLocation)
               let formattedDistance = Measurement(value: distance, unit: UnitLength.meters).converted(to: .kilometers)
               
               print("Расстояние: \(formattedDistance)")
               onDistanceUpdated?(formattedDistance.value)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if overlay is MKPolyline {
                let renderer = MKPolylineRenderer(overlay: overlay)
                renderer.strokeColor = UIColor(Color("line"))
                renderer.lineWidth = 5
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
