//
//  FavouritesView.swift
//  GhibliApp
//
//  Created by Ammar Saber on 11/08/2026.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(FavoritesStore.self) private var favorites
    @Environment(FilmsListViewModel.self) private var filmsVM

    var favoriteFilms: [Film] {
        filmsVM.films.filter { favorites.isFavorite($0.id) }
    }

    var body: some View {
        NavigationStack {
            Group {
                if filmsVM.isLoading && filmsVM.films.isEmpty {
                    ProgressView("Loading favorites...")
                } else if let error = filmsVM.errorMessage,
                    filmsVM.films.isEmpty
                {
                    ContentUnavailableView(
                        "Error",
                        systemImage: "exclamationmark.triangle",
                        description: Text(error)
                    )
                } else if favoriteFilms.isEmpty {
                    ContentUnavailableView(
                        "No Favorites Yet",
                        systemImage: "heart",
                        description: Text(
                            "Tap the heart on films to see them here."
                        )
                    )
                } else {
                    List(favoriteFilms) { film in
                        FilmCardView(film: film)
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView()
        .environment(FilmsListViewModel())
        .environment(FavoritesStore())
}
