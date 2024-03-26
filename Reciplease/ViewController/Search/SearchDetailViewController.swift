//
//  SearchDetailViewController.swift
//  Reciplease
//
//  Created by François-Xavier on 25/03/2024.
//

import UIKit

class SearchDetailViewController: UIViewController {
    
    //MARK: - Property
    var model = SearchRecipeModel()
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        tabBarController?.tabBar.isHidden = true
        
        likeLabel.text = model.selectedRecipe?.yield.description
        durationLabel.text = model.selectedRecipe?.durationFormatted
        imageView.load(imageURL: model.selectedRecipe?.image)
        ingredientTableView.reloadData()
        
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let destinationVC = segue.destination as? WebViewController else { return }
            destinationVC.model = self.model
//            performSegue(withIdentifier: "recipeWebView", sender: nil)
        }
    
    //MARK: - Action
    @IBAction func addFavorite(_ sender: Any) {
        // CoreData Integration
    }
    
    //MARK: - Private
    private func configureTableView() {
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
    }
    
}


extension SearchDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let row = model.selectedRecipe?.ingredientLines.count else {
            return 0
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.selectedRecipe?.ingredientLines[indexPath.row].description
        return cell
    }
}

#warning("move it")
extension UIImageView {
    func load(imageURL: String?) {
        guard let url = URL(string: imageURL ?? "") else {
            return
        }
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
