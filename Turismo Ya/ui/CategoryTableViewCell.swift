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
    
    var categoryId: Int16 = 0
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBAction func showCategoryMapPressed(_ sender: Any) {
        // print("Mostrar mapa de \(String(describing: categoryNameLabel.text))")
        
        delegate?.openMapView(categoryId: self.categoryId)
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
