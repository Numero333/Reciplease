//
//  SearchViewController.swift
//  Reciplease
//
//  Created by François-Xavier on 24/03/2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - Property
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var ingredientTextfield: UITextField!
    private var listOfIngredient = [String]()
    // Instanciate NETWORK
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTableView.dataSource = self
        ingredientTableView.delegate = self
        tabBarController?.tabBar.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? SearchListViewController else { return }
    }
    
    //MARK: - Action
    @IBAction func addIngredientButton(_ sender: Any) {
        addIngredient()
    }
    
    //MARK: - Private
    private func addIngredient() {
        if let ingredient = ingredientTextfield.text {
            listOfIngredient.append(ingredient)
            ingredientTableView.reloadData()
            ingredientTextfield.text = ""
        }
    }
}


extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfIngredient.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listOfIngredient[indexPath.row]
        return cell
    }
}
