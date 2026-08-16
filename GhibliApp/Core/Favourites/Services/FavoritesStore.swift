//
//  FavoritesStore.swift
//  GhibliApp
//
//  Created by Ammar Saber on 16/08/2026.
//

import Observation
import Foundation

@Observable
@MainActor
final class FavoritesStore {
    private(set) var favoriteIDs: Set<String> = []
    
    private let storageKey = "favoriteFilmIDs"
    private let defaults = UserDefaults.standard
    
    init() {
        load()
    }
    
    func isFavorite(_ id: String) -> Bool {
        favoriteIDs.contains(id)
    }
    
    func toggle(_ id: String) {
        if favoriteIDs.contains(id) {
            favoriteIDs.remove(id)
        } else {
            favoriteIDs.insert(id)
        }
        save()
    }
    
    private func load() {
        if let data = defaults.data(forKey: storageKey),
           let array = try? JSONDecoder().decode([String].self, from: data) {
            favoriteIDs = Set(array)
        }
    }
    
    private func save() {
        let array = Array(favoriteIDs)
        if let data = try? JSONEncoder().encode(array) {
            defaults.set(data, forKey: storageKey)
        }
    }
}
