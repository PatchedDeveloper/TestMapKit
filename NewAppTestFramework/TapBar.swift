//
//  TapBarView.swift
//  CryptoMetricsSwiftUI
//
//  Created by Danila Kardashevkii on 22.06.2023.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
            findMapView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

        }
        .accentColor(.pink)
        .background(.black)
    }
}
