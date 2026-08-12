//
//  FilmService.swift
//  GhibliApp
//
//  Created by Ammar Saber on 11/08/2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case badServerResponse
}

struct FilmService {
    static func fetchAllFilms() async throws -> [Film] {
        guard let url = URL(string: APIConstants.filmsURL) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.badServerResponse
        }
        
        return try JSONDecoder().decode([Film].self, from: data)
    }
    
    static func fetchFilm(withId: String) async throws -> Film {
        guard let url = URL(string: "\(APIConstants.filmsURL)/\(withId)") else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.badServerResponse
        }
        
        return try JSONDecoder().decode(Film.self, from: data)
    }
}
