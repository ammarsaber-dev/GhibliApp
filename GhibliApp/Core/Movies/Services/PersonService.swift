//
//  PersonService.swift
//  GhibliApp
//
//  Created by Ammar Saber on 12/08/2026.
//

import Foundation

struct PersonService {
    static func fetchCharacters(inFilm film: Film) async throws -> [Person] {
        // Some films include a generic people collection URL (e.g., "https://ghibliapi.vercel.app/people/")
        // which should not be fetched as an individual person resource. Filter these out.
        let validPeopleURLs: [String] = film.people.filter { personURL in
            guard let url = URL(string: personURL) else { return false }
            // Reject if the path ends with "/people" or "/people/" and has no further path components
            let path = url.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
            let components = path.split(separator: "/")
            // Accept only if path looks like "people/{id}" (i.e., at least 2 components)
            return components.count >= 2
        }

        // If no valid person endpoints remain, return empty list
        if validPeopleURLs.isEmpty {
            return []
        }

        return try await withThrowingTaskGroup(of: Person.self) { group in
            for personURL in validPeopleURLs {
                guard let url = URL(string: personURL) else {
                    throw NetworkError.invalidURL
                }

                group.addTask {
                    let (data, response) = try await URLSession.shared.data(
                        from: url
                    )

                    guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode)
                    else {
                        throw NetworkError.badServerResponse
                    }
                    
                    print("URL:", url)
                        print("STATUS:", httpResponse.statusCode)
                        print("JSON:", String(data: data, encoding: .utf8) ?? "Invalid UTF-8")

                    return try JSONDecoder().decode(
                        Person.self,
                        from: data
                    )
                }
            }

            var people = [Person]()

            for try await person in group {
                people.append(person)
            }

            return people
        }
    }
}
