//
//  SearchViewController.swift
//  Reciplease
//
//  Created by François-Xavier on 24/03/2024.
//

import UIKit

final class SearchViewController: UIViewController, SearchRecipeDelegate {
    
    //MARK: - Property
    private let model = SearchModel()
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var ingredientTextfield: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        configureTableView()
        activityIndicator.isHidden = true
        self.hidesBottomBarWhenPushed = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? SearchListViewController else { return }
        
        if let recipes = model.recipes {
            destinationVC.model = SearchListModel(recipes: recipes)
        }
    }
    
    //MARK: - AppServiceDelegate
    func didLoadData(result: Bool) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "RecipeList", sender: nil)
            self.toggleActivityIndicator()
        }
    }
    
    //MARK: - Action
    @IBAction func SearchButton(_ sender: Any) {
        toggleActivityIndicator()
        model.loadData()
    }
    
    @IBAction func addIngredientButton(_ sender: Any) {
        if let ingredient = ingredientTextfield.text, !ingredient.isEmpty {
            model.addIngredient(text: ingredient)
            ingredientTableView.reloadData()
            ingredientTextfield.text = ""
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.ingredientTextfield.resignFirstResponder()
    }
    
    @IBAction func clearButton(_ sender: Any) {
        model.clearListIngredient()
        ingredientTableView.reloadData()
    }
    
    //MARK: - Private
    private func configureTableView() {
        ingredientTableView.dataSource = self
        ingredientTableView.delegate = self
    }
    
    private func toggleActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden ?  self.activityIndicator.startAnimating() :  self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden.toggle()
        }
    }
}


extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.inputListIngredient.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.inputListIngredient[indexPath.row]
        return cell
    }
}
