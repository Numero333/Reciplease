//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by François-Xavier on 19/03/2024.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
        
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    static let identifier = "RecipeCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "RecipeTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
