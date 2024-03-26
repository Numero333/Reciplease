//
//  SearchViewController.swift
//  Reciplease
//
//  Created by François-Xavier on 24/03/2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - Property
    let model = SearchRecipeModel()
    
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var ingredientTextfield: UITextField!
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? SearchListViewController else { return }

        destinationVC.model = self.model
    }
    
    //MARK: - Action
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
