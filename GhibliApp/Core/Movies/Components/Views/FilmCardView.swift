//
//  FilmCardView.swift
//  GhibliApp
//
//  Created by Ammar Saber on 11/08/2026.
//

import SwiftUI

struct FilmCardView: View {
    @Environment(FavoritesStore.self) private var favorites

    let film: Film
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: film.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFill()
            .frame(width: 100, height: 160)
            .padding(.trailing, 8)

            VStack(alignment: .leading) {
                HStack {
                    Text(film.title)
                        .font(.headline)
                        .fontWeight(.semibold)

                    Spacer()

                    Button {
//                        favorites.toggle(film.id)
                    } label: {
                        Image(
                            systemName: favorites.isFavorite(film.id)
                                ? "heart.fill" : "heart"
                        )
                        .tint(.red)
                    }
                }

                VStack(alignment: .leading) {
                    Text("Directed by \(film.director)")
                        .font(.footnote)

                    Text("Released: \(film.releaseDate)")
                        .font(.caption)
                }
                .foregroundStyle(.gray)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    FilmCardView(film: .sample)
        .environment(FavoritesStore())
}
