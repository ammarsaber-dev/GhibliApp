//
//  FilmDetailsViewModel.swift
//  GhibliApp
//
//  Created by Ammar Saber on 12/08/2026.
//

import Foundation

@MainActor
@Observable
class FilmDetailsViewModel {
    let film: Film
    var people = [Person]()

    var isLoading = false
    var errorMessage: String?

    init(film: Film) {
        self.film = film
    }

    func fetchFilmCharacters() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            people = try await PersonService.fetchCharacters(inFilm: film)
            errorMessage = nil
        } catch {
            errorMessage = "Failed to load people: \(error.localizedDescription)"
        }
    }
}
