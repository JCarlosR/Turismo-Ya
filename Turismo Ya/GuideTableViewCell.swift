//
//  GuideTableViewCell.swift
//  Turismo Ya

import UIKit

class GuideTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageViewSexo: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
