//
//  SearchDetailModel.swift
//  Reciplease
//
//  Created by François-Xavier on 27/03/2024.
//

import Foundation

final class SearchDetailModel {
    
    //MARK: - Property
    var selectedRecipe: RecipeDescription
    
    //MARK: - Initialization
    init(selectedRecipe: RecipeDescription) {
        self.selectedRecipe = selectedRecipe
    }
}
