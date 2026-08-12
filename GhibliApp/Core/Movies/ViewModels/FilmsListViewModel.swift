//
//  FilmsListViewModel.swift
//  GhibliApp
//
//  Created by Ammar Saber on 11/08/2026.
//

import Foundation

@MainActor
@Observable
final class FilmsListViewModel {
    var films = [Film]()
    var isLoading = false
    var errorMessage: String?

    func fetchAllFilms() async {
        isLoading = true
        defer { isLoading = false }

        errorMessage = nil

        do {
            films = try await FilmService.fetchAllFilms()
        } catch {
            errorMessage = "Failed to load films: \(error.localizedDescription)"
        }
    }
}
