//
//  FavoriteListViewController.swift
//  Reciplease
//
//  Created by François-Xavier on 26/03/2024.
//

import UIKit

final class FavoriteListViewController: UIViewController, FavoriteListDelegate {
    
    //MARK: - Property
    let model = FavoriteListModel()
    @IBOutlet weak var recipeTableView: UITableView!
    private let coreDataService = CoreDataService.shared
    
    override func viewDidLoad() {
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        recipeTableView.register(RecipeTableViewCell.nib(), forCellReuseIdentifier: RecipeTableViewCell.identifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? FavoriteDetailViewController else { return }
        if let selection = model.selectedRecipe {
            destinationVC.model = FavoriteDetailModel(recipe: selection)
        }
    }
    
    //MARK: - AppServiceDelegate
    func didLoadData(result: Bool) {
        DispatchQueue.main.async {
            self.recipeTableView.reloadData()
        }
    }
}

extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selection = model.recipes?[indexPath.row]
        model.selectedRecipe = selection
        performSegue(withIdentifier: "FavorisDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.recipes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        if let recipe = model.recipes {
            cell.title.text = recipe[indexPath.row].label
            cell.subTitle.text = recipe[indexPath.row].ingredients
            cell.likeLabel.text = recipe[indexPath.row].yield.description
            cell.durationLabel.text = recipe[indexPath.row].duration
            cell.backgroundImage.loadImageFromData(for: recipe[indexPath.row].image)
        }
        return cell
    }
}

extension UIImageView {
    func loadImageFromData(for data: Data?) {
        if let data = data {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
                
            }
        } else {
            // If the recipe does not have an image
            DispatchQueue.main.async {
                self.image = UIImage(systemName: "fork.knife")
            }
        }
    }
}
