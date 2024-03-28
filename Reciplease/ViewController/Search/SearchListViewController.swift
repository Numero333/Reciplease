//
//  SearchListViewController.swift
//  Reciplease
//
//  Created by François-Xavier on 24/03/2024.
//

import UIKit

final class SearchListViewController: UIViewController {
    
    //MARK: - Property
    var model: SearchListModel!
    @IBOutlet weak var recipeTableView: UITableView!
    
    //MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.hidesBottomBarWhenPushed = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? SearchDetailViewController else { return }
        if let selection = model.selectedRecipe {
            destinationVC.model = SearchDetailModel(selectedRecipe: selection)
        }
    }
    
    //MARK: - Private
    private func configureTableView() {
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        recipeTableView.register(RecipeTableViewCell.nib(), forCellReuseIdentifier: RecipeTableViewCell.identifier)
    }
}

extension SearchListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selection = model.recipes?.results[indexPath.row].recipe
        model.selectedRecipe = selection
        performSegue(withIdentifier: "recipeDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.recipes?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = recipeTableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        if let recipe = model.recipes?.results[indexPath.row].recipe {
            configureCell(with: recipe)
        }
        return cell
        
        func configureCell(with recipe: RecipeDescription) {
            cell.title.text = recipe.label.description
            cell.subTitle.text = recipe.ingredientLines.joined(separator: " ")
            cell.backgroundImage.loadImage(for: recipe.image)
            cell.likeLabel.text = recipe.yield.description
            cell.durationLabel.text = recipe.durationFormatted
        }
    }
}

extension UIImageView {
    func loadImage(for imageURL: String?) {
        if let urlString = imageURL, let url = URL(string: urlString) {
            DispatchQueue.global(qos: .background).async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                    }
                } else {
                    // If loading image fail
                    DispatchQueue.main.async {
                        self.image = UIImage(systemName: "fork.knife")
                    }
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
