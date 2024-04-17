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
    
    @IBOutlet weak var messageEmptyRecipe: UILabel!
    override func viewDidLoad() {
        model.delegate = self
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        recipeTableView.register(RecipeTableViewCell.nib(), forCellReuseIdentifier: RecipeTableViewCell.identifier)
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        model.loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? FavoriteDetailViewController else { return }
        if let selection = model.selectedRecipe {
            destinationVC.model = FavoriteDetailModel(recipe: selection)
        }
    }
    
    //MARK: - FavoriteListDelegate
    func didLoadData(result: Bool) {
        DispatchQueue.main.async {
            self.configureView()
            self.recipeTableView.reloadData()
        }
    }
    
    private func configureView() {
        DispatchQueue.main.async {
            if let recipes = self.model.recipes, !recipes.isEmpty {
                self.messageEmptyRecipe.isHidden = true
                self.recipeTableView.isHidden = false
            } else {
                self.recipeTableView.isHidden = true
                self.messageEmptyRecipe.isHidden = false
            }
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
            cell.backgroundImage.loadImage(for: recipe[indexPath.row].image)
        }
        return cell
    }
}
