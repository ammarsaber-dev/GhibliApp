//
//  Film.swift
//  GhibliApp
//
//  Created by Ammar Saber on 11/08/2026.
//

import Foundation

struct Film: Identifiable, Codable, Hashable {
    let id: String
    
    let title: String
    let originalTitle: String // original_title
    let romanisedTitle: String // original_title_romanised
    let description: String
    
    let image: String
    let movieBanner: String // movie_banner
    
    let director: String
    let producer: String
    
    let releaseDate: String // release_date
    let runningTime: String // running_time
    
    let score: String // rt_score
    
    let people: [String]
    let species: [String]
    let locations: [String]
    let vehicles: [String]
    
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, image, director, producer, people, species, locations, vehicles, url
        
        case originalTitle = "original_title"
        case romanisedTitle = "original_title_romanised"
        case movieBanner = "movie_banner"
        case releaseDate = "release_date"
        case runningTime = "running_time"
        case score = "rt_score"
    }
}
