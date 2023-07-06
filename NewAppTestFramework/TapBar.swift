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
                    Image(systemName: "location.fill")
                    Text("Map")
                }
            findMapView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }

        }
        .accentColor(.pink)
        .background(.black)
    }
}
