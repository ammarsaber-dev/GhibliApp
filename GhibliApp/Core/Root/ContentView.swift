//
//  ContentView.swift
//  GhibliApp
//
//  Created by Ammar Saber on 11/08/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var filmsVM = FilmsListViewModel()
    
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper.fill") {
                FilmsListView()
                    .environment(filmsVM)
            }
            
            Tab("Favorites", systemImage: "heart.fill") {
                FavoritesView()
                    .environment(filmsVM)
            }
            
            Tab("Settings", systemImage: "gearshape.fill") {
                SettingsView()
            }
            
            Tab("Search", systemImage: "magnifyingglass", role: .search) {
                SearchView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(FilmsListViewModel())
        .environment(FavoritesStore())
}
