//
//  FilmDetailsView.swift
//  GhibliApp
//
//  Created by Ammar Saber on 11/08/2026.
//

import SwiftUI

struct FilmDetailsView: View {
    @Environment(FavoritesStore.self) var favorites
    
    @State private var viewModel: FilmDetailsViewModel

    init(film: Film) {
        _viewModel = State(wrappedValue: FilmDetailsViewModel(film: film))
    }

    var film: Film {
        viewModel.film
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: film.movieBanner)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        ProgressView()
                    }

                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 16) {
                            VStack(alignment: .leading) {
                                Text(film.title)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .fontWidth(.expanded)

                                HStack {
                                    Text(film.originalTitle)
                                    Text("(\(film.romanisedTitle))")
                                }
                                .font(.footnote)
                                .foregroundStyle(.gray)
                            }

                            Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 8) {
                                GridRow {
                                    Text("Director")
                                        .fontWeight(.medium)
                                    Text(film.director)
                                }
                                GridRow {
                                    Text("Producer")
                                        .fontWeight(.medium)
                                    Text(film.producer)
                                }
                                GridRow {
                                    Text("Release Date")
                                        .fontWeight(.medium)
                                    Text(film.releaseDate)
                                }
                                GridRow {
                                    Text("Running Time")
                                        .fontWeight(.medium)
                                    Text("\(film.runningTime) minutes")
                                }
                                GridRow {
                                    Text("Score")
                                        .fontWeight(.medium)
                                    Text("\(film.score)/100")
                                }
                            }
                        }

                        Divider()

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.headline)
                                .fontWeight(.semibold)

                            Text(film.description)
                                .lineLimit(nil)
                        }
                        .padding(.vertical)

                        VStack(alignment: .leading, spacing: 16) {
                            Text("Characters")
                                .font(.headline)
                                .fontWeight(.bold)

                            VStack(alignment: .leading, spacing: 16) {
                                if viewModel.isLoading {
                                    ProgressView("Loading people ...")
                                } else if let errorMessage = viewModel
                                    .errorMessage
                                {
                                    Text(errorMessage)
                                        .foregroundStyle(.red)
                                } else {
                                    if viewModel.people.isEmpty {
                                        Text("No characters found.")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                    } else {
                                        ForEach(viewModel.people) { person in
                                            VStack(alignment: .leading) {
                                                Text(person.name)
                                                    .font(.headline)
                                                    .fontWeight(.medium)

                                                Grid(
                                                    alignment: .leading,
                                                    horizontalSpacing: 12
                                                ) {
                                                    GridRow {
                                                        HStack(spacing: 6) {
                                                            Image(
                                                                systemName:
                                                                    "person.fill"
                                                            )
                                                            Text(
                                                                "\(person.gender), Age: \(person.age)"
                                                            )
                                                        }
                                                        .frame(
                                                            maxWidth: .infinity,
                                                            alignment: .leading
                                                        )

                                                        HStack(spacing: 6) {
                                                            Image(
                                                                systemName:
                                                                    "eye"
                                                            )
                                                            Text(
                                                                "\(person.eyeColor), Hair: \(person.hairColor)"
                                                            )
                                                        }
                                                        .frame(
                                                            maxWidth: .infinity,
                                                            alignment: .leading
                                                        )
                                                    }

                                                }
                                                .font(.footnote)
                                                .foregroundStyle(.gray)
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.7)
                                            }

                                            if person.id
                                                != viewModel.people.last?.id
                                            {
                                                Divider()
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding()
                }
            }
        }
        .task {
            await viewModel.fetchFilmCharacters()
        }
        .navigationTitle(film.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    favorites.toggle(film.id)
                } label: {
                    Label("Mark as favourite", systemImage: favorites.isFavorite(film.id) ? "heart.fill" : "heart")
                }
                .tint(.red)
            }
        }
    }
}

#Preview {
    FilmDetailsView(film: .sample)
        .environment(FavoritesStore())
}
