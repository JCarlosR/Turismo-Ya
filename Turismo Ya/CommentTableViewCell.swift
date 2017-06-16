//
//  CommentTableViewCell.swift
//  Turismo Ya
//
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labelAuthorName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelComment: UILabel!
        
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    var stars: String = ""
    
    var imageStarOn = UIImage(named: "star-on.png")
    var imageStarOff = UIImage(named: "star-off.png")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // remove top padding
        self.labelComment.sizeToFit()
        
        // Initialization code
        // paintStarsUpTo(stars: Int(self.stars)!)
    }

    func paintStarsUpTo(stars: Int) {
        if stars >= 1 {
            star1.image = imageStarOn
        } else {
            star1.image = imageStarOff
        }
        
        if stars >= 2 {
            star2.image = imageStarOn
        } else {
            star2.image = imageStarOff
        }
        
        if stars >= 3 {
            star3.image = imageStarOn
        } else {
            star3.image = imageStarOff
        }
        
        if stars >= 4 {
            star4.image = imageStarOn
        } else {
            star4.image = imageStarOff
        }
        
        if stars == 5 {
            star5.image = imageStarOn
        } else {
            star5.image = imageStarOff
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
