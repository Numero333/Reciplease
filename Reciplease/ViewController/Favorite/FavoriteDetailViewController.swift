//
//  FavoriteDetailViewController.swift
//  Reciplease
//
//  Created by François-Xavier on 31/03/2024.
//

import UIKit

final class FavoriteDetailViewController: UIViewController {
    
    //MARK: - Property
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var likeButton: UIBarButtonItem!
    var model: FavoriteDetailModel!
    var likeState = false
    
    //MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        configureView()
        configureTableView()
        
        likeLabel.accessibilityHint = "likes"
        durationLabel.accessibilityHint = "duration"
        likeButton.accessibilityHint = "favorite button"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? WebViewController else { return }
        destinationVC.model = WebViewModel(url: model.recipe.url ?? "")
    }
    
    
    //MARK: - Private
    private func configureTableView() {
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
    }
    
    private func configureView() {
        likeLabel.text = model.recipe.yield.description
        durationLabel.text = model.recipe.duration?.description
        imageView.loadImageFromData(for: model.recipe.image)
    }
    
}

extension FavoriteDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.ingredients[indexPath.row].description
        return cell
        
    }
}
