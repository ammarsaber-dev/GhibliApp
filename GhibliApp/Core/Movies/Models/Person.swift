//
//  Person.swift
//  GhibliApp
//
//  Created by Ammar Saber on 11/08/2026.
//

import Foundation

nonisolated struct Person: Identifiable, Codable, Sendable {
    let id: String
    
    let name: String
    let gender: String
    let age: String
    
    let eyeColor: String
    let hairColor: String
    
    let films: [String]
    let species: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, gender, age, films, species, url
        
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
    }
}
