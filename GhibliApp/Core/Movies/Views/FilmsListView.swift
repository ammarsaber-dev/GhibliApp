//
//  FilmsListView.swift
//  GhibliApp
//
//  Created by Ammar Saber on 11/08/2026.
//

import SwiftUI

struct FilmsListView: View {
    @Environment(FilmsListViewModel.self) private var filmsVM

    var body: some View {
        NavigationStack {
            Group {
                if filmsVM.isLoading {
                    ProgressView("Loading films...")
                } else if let errorMessage = filmsVM.errorMessage {
                    ContentUnavailableView(
                        "Error",
                        systemImage: "exclamationmark.triangle",
                        description: Text(errorMessage)
                    )
                } else {
                    List(filmsVM.films) { film in
                        NavigationLink(value: film) {
                            FilmCardView(film: film)
                        }
                    }
                }
            }
            .task {
                await filmsVM.fetchAllFilms()
            }
            .navigationTitle("Ghibli Films")
            .navigationDestination(for: Film.self) { film in
                FilmDetailsView(film: film)
            }
        }
    }
}

#Preview {
    FilmsListView()
        .environment(FilmsListViewModel())
        .environment(FavoritesStore())
}
