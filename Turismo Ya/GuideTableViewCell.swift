//
//  GuideTableViewCell.swift
//  Turismo Ya
//
//  Created by rimenri on 10/05/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

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
