//
//  GhibliAppApp.swift
//  GhibliApp
//
//  Created by Ammar Saber on 11/08/2026.
//

import SwiftUI

@main
struct GhibliAppApp: App {
    @State private var favorites = FavoritesStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(favorites)
        }
    }
}
