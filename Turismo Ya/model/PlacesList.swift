//
//  PlacesList.swift
//  Turismo Ya
//
//  Created by rimenri on 03/03/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import SDWebImage

class PlacesList: NSObject {
    
    weak var delegate: ShowPlaceInfoDelegate?
    
    var places: [Place] = []
    var filteredPlaces: [Place] = []
    
    // applied filters
    var subCategoryId: Int16 = 0
    var scoreId: Int16 = 0
    
    func addPlace(place: Place) {
        places.append(place)
        filteredPlaces.append(place)
    }
    
    func applyFilter(subCategoryId: Int16) {
        self.subCategoryId = subCategoryId
        applyFilter()
    }
    
    func applyFilter(scoreId: Int16) {
        self.scoreId = scoreId
        applyFilter()
    }
    
    func applyFilter() {
        filteredPlaces.removeAll()
        
        for place in places {
            let belongsToSubCategory: CBool = (subCategoryId == 0 || place.idSubLinea == subCategoryId)
            let belongsToScore: CBool = (scoreId == 0  || place.idValoracion == scoreId)
            if belongsToSubCategory && belongsToScore {
                filteredPlaces.append(place)
            }
        }
    }
}

protocol ShowPlaceInfoDelegate: class {
    func didSelectPlace(place: Place)
}


extension PlacesList: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Celda que vamos a pintar
        let cell = Bundle.main.loadNibNamed("PlaceTableViewCell", owner: self, options: nil)?.first as! PlaceTableViewCell
        
        // Datos del lugar con índice row
        let place = filteredPlaces[indexPath.row]
        
        // Asignamos los valores a la celda y devolvemos
        let imageUrl = URL(string: "http://52.170.87.192:50/premiun/images/producto/\(place.imageUrl)")
        cell.placeImageView.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "logo.png")
            , options: SDWebImageOptions.progressiveDownload)
        cell.placeNameLabel.text = place.abrev
        cell.placeDescriptionLabel.text = place.descripcion
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Se hizo clic sobre el lugar \(filteredPlaces[indexPath.row].abrev)")
        delegate?.didSelectPlace(place: places[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 125 }
}

