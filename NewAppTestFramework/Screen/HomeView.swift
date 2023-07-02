//
//  HomeView.swift
//  NewAppTestFramework
//
//  Created by Danila Kardashevkii on 02.07.2023.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var mapData = MapViewModel()
    
    //LocationManager
    @State var locationManager = CLLocationManager()
    
    
    var body: some View {
        ZStack {
            MapView()
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
            
            HStack{
                Spacer()
                VStack{
                    Spacer()
                    VStack{
                        Button {
                            mapData.focusLocation()
                        } label: {
                            Image(systemName: "location.fill" )
                                .font(.title2)
                                .padding()
                                .background(Color.primary)
                                .clipShape(Circle())
                        }
                        
                        Button {
                            mapData.updateMapType()
                        } label: {
                            Image(systemName: mapData.mapType == .standard ? "network" : "map" )
                                .font(.title2)
                                .padding()
                                .background(Color.primary)
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                }
            }

        }
        .cornerRadius(20)
        .padding(.vertical)
        .onAppear(perform: {
            locationManager.delegate = mapData
            locationManager.requestWhenInUseAuthorization()
        })
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
