//
//  CategoryTableViewCell.swift
//  Turismo Ya
//
//  Created by rimenri on 22/02/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    weak var delegate: OpenMapDelegate?
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBAction func showCategoryMapPressed(_ sender: Any) {
        print("Mostrar mapa de \(categoryNameLabel.text)")
        
        delegate?.openMapView()
        // self.performSegue(withIdentifier: "showMapSegue", sender: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
