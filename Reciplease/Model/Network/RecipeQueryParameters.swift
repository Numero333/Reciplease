//
//  RecipeQueryParameters.swift
//  Reciplease
//
//  Created by François-Xavier on 14/03/2024.
//

import Foundation

struct RecipeQueryParameters: Encodable {
    
    let query: String
    let type: String
    let appKey: String
    let appId: String
    
    init(query: String) {
        self.query = query
        self.type = "public"
        self.appId = APIKey.appId
        self.appKey = APIKey.appKey
    }
    
    var value: [String:String] {
        return [
            "type" : type,
            "q" : query,
            "app_key" : appKey,
            "app_id" : appId
        ]
    }
}
