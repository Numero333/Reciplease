//
//  SearchDetailViewController.swift
//  Reciplease
//
//  Created by François-Xavier on 25/03/2024.
//

import UIKit

final class SearchDetailViewController: UIViewController, SearchDetailDelegate {
    
    //MARK: - Property
    var model: SearchDetailModel!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var informationBlock: UIView!
    //MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        model.loadData()
        configureUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? WebViewController else { return }
        destinationVC.model = WebViewModel(url: model.selectedRecipe.url)
    }
    
    //MARK: - SearchDetailDelegate
    func didUpdate(liked: Bool) {
        let imageSystem = liked ? "star.fill" : "star"
        DispatchQueue.main.async {
            self.favoriteButton.image = UIImage(systemName: imageSystem)
        }
    }
    
    //MARK: - Action
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        model.handleFavoriteButton()
    }
    
    //MARK: - Private
    private func configureTableView() {
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
    }
    
    private func configureUI() {
        likeLabel.text = model.selectedRecipe.yield.description
        durationLabel.text = model.selectedRecipe.durationFormatted
        imageView.loadImage(for: model.selectedRecipe.image)
        informationBlock.customBorder()
        
        configureTableView()
        ingredientTableView.reloadData()
        configureAccessibility()
    }
    
    private func configureAccessibility() {
        likeLabel.accessibilityValue = "likes"
        durationLabel.accessibilityValue = "preparation time"
        favoriteButton.accessibilityLabel = "add to favorite button"
    }
}


extension SearchDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = model.selectedRecipe.ingredientLines.count
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.selectedRecipe.ingredientLines[indexPath.row].description
        return cell
    }
}
