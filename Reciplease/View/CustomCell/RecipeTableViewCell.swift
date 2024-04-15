//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by François-Xavier on 19/03/2024.
//

import UIKit

final class RecipeTableViewCell: UITableViewCell {
    
    //MARK: - Property
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var informationBlock: UIView!
    
    static let identifier = "RecipeCell"
    
    // MARK: - Accessible
    static func nib() -> UINib {
        return UINib(nibName: "RecipeTableViewCell", bundle: nil)
    }
    
    //MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        title.customShadow()
        subTitle.customShadow()
        informationBlock.customBorder()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with recipe: RecipeDescription) {
        self.title.text = recipe.label.description
        self.subTitle.text = recipe.ingredientLines.joined(separator: " ")
        self.backgroundImage.loadImage(for: recipe.image)
        self.likeLabel.text = recipe.yield.description
        self.durationLabel.text = recipe.durationFormatted
    }
}

extension UILabel {
    func customShadow() {
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 2.0;
        self.layer.shadowOffset = .init(width: 0, height: 2)
    }
}

extension UIView {
    func customBorder() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(.white).cgColor
        self.layer.cornerRadius = 5
    }
}
