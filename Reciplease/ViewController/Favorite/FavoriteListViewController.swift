//
//  FavoriteListViewController.swift
//  Reciplease
//
//  Created by François-Xavier on 26/03/2024.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    //MARK: - Property
    @IBOutlet weak var recipeTableView2: UITableView!
}

extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "recipeDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = recipeTableView2.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.title.text = "TestMode"
        return cell
    }
    
    

}
