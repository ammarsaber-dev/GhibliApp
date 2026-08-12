//
//  FilmsListView.swift
//  GhibliApp
//
//  Created by Ammar Saber on 11/08/2026.
//

import SwiftUI

struct FilmsListView: View {
    @State private var viewModel = FilmsListViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading films...")
                } else if let errorMessage = viewModel.errorMessage {
                    ContentUnavailableView(
                        "Error",
                        systemImage: "exclamationmark.triangle",
                        description: Text(errorMessage)
                    )
                } else {
                    List(viewModel.films) { film in
                        NavigationLink(value: film) {
                            FilmCardView(film: film)
                        }
                    }
                }
            }
            .task {
                await viewModel.fetchAllFilms()
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
}
