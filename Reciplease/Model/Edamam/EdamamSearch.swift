//
//  EdamamSearch.swift
//  Reciplease
//
//  Created by François-Xavier on 13/03/2024.
//

import Foundation
import UIKit

struct EdamamSearch: Decodable {
    let results: [Recipe]
    
    enum CodingKeys: String, CodingKey {
        case results = "hits"
    }
}

// MARK: - Recipe
struct Recipe: Decodable {
    let recipe: RecipeDescription
}

// MARK: - Recipe Description
struct RecipeDescription: Decodable {
    let label: String
    let image: String?
    let url: String
    let yield: Int
    let ingredientLines: [String]
    let totalTime: Int?
    
    var durationFormatted: String {
        return timeFormatter(for: totalTime)
    }
}


extension RecipeDescription {
    private func timeFormatter(for time: Int?) -> String {
        if let time = time, time > 0 {
            let hours = time / 60
            let minutes = time % 60
            return "\(hours):\(minutes)"
        } else {
            return "N/A"
        }
    }
}
