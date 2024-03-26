//
//  SearchListViewController.swift
//  Reciplease
//
//  Created by François-Xavier on 24/03/2024.
//

import UIKit

class SearchListViewController: UIViewController {
    
    //MARK: - Property
    #warning("Val")
    var model = SearchRecipeModel()
    @IBOutlet weak var recipeTableView: UITableView!
        
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        tabBarController?.tabBar.isHidden = true
        
        model.loadData()
        #warning("Val")
        Thread.sleep(forTimeInterval: 1)
        recipeTableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? SearchDetailViewController else { return }
        destinationVC.model = self.model
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
        // Dans le model ?
        model.selectedRecipe = model.recipes?.result[indexPath.row].recipe
        
        performSegue(withIdentifier: "recipeDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.recipes?.result.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = recipeTableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        // IMAGE -> tu l'a dupliqué fait mieux Berk!
        if let urlString = model.recipes?.result[indexPath.row].recipe.image, let url = URL(string: urlString) {
            DispatchQueue.global(qos: .background).async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.backgroundImage.image = UIImage(data: data)
                    }
                } else {
                    // If loading image fail
                    DispatchQueue.main.async {
                        cell.backgroundImage.image = UIImage(systemName: "fork.knife")
                    }
                }
            }
        } else {
            // If the recipe does not have an image
            DispatchQueue.main.async {
                cell.backgroundImage.image = UIImage(systemName: "fork.knife")
            }
        }
        
        // TITLE
        cell.title.text = model.recipes?.result[indexPath.row].recipe.label
        // SUBTITLE
        cell.subTitle.text = model.recipes?.result[indexPath.row].recipe.ingredientLines.joined(separator: ", ")
        // LIKES
        cell.likeLabel.text = model.recipes?.result[indexPath.row].recipe.yield.description
        // DURATION
        cell.durationLabel.text = timeFormatter(for: model.recipes?.result[indexPath.row].recipe.totalTime)
        
        return cell
    }
    
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
