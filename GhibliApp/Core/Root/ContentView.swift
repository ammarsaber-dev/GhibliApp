//
//  ContentView.swift
//  GhibliApp
//
//  Created by Ammar Saber on 11/08/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper.fill") {
                FilmsListView()
            }
            
            Tab("Favourites", systemImage: "heart.fill") {
                FavouritesView()
            }
            
            Tab("Settings", systemImage: "gearshape.fill") {
                SettingsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
