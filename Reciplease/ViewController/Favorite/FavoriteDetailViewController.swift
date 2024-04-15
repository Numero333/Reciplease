//
//  FavoriteDetailViewController.swift
//  Reciplease
//
//  Created by François-Xavier on 31/03/2024.
//

import UIKit

final class FavoriteDetailViewController: UIViewController, FavoriteDetailDelegate {
    func didUpdate(liked: Bool) {
        let imageSystem = liked ? "star.fill" : "star"
        DispatchQueue.main.async {
            self.likeButton.image = UIImage(systemName: imageSystem)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - Property
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var likeButton: UIBarButtonItem!
    @IBOutlet weak var informationBlock: UIView!
    var model: FavoriteDetailModel!
    var likeState = true
    
    //MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        configureAccessibility()
        informationBlock.customBorder()
        model.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? WebViewController else { return }
        if let url = model.recipe.url {
            destinationVC.model = WebViewModel(url: url)
        }
       
    }
    
    
    @IBAction func toggleFavoriteButton(_ sender: Any) {
       presentAlert()
    }
    //MARK: - Private
    private func configureTableView() {
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
    }
    
    private func configureView() {
        likeLabel.text = model.recipe.yield.description
        durationLabel.text = model.recipe.duration?.description
        imageView.loadImage(for: model.recipe.image)
    }
    
    private func configureAccessibility() {
        likeLabel.accessibilityHint = "likes"
        durationLabel.accessibilityHint = "duration"
        likeButton.accessibilityHint = "favorite button"
    }
    
    private func presentAlert() {
        let alertController = UIAlertController(title: "Delete Recipe", message: "Do you want to delete this recipe ?", preferredStyle: .alert)

        let actionOK = UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.model.delete()
        })

        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            alertController.dismiss(animated: true)
        })

        alertController.addAction(actionCancel)
        alertController.addAction(actionOK)
        

        present(alertController, animated: true, completion: nil)
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
