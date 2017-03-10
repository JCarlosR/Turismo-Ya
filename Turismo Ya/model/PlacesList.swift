//
//  PlacesList.swift
//  Turismo Ya
//
//  Created by rimenri on 03/03/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit


struct Place {
    let name: String!
    let image: UIImage!
}

class PlacesList: NSObject {
    
    var places: [Place] = []
    
    func addPlace(placeName: String) {
        places.append(
            Place(
                name: placeName,
                image: #imageLiteral(resourceName: "pajaro azul")
            )
        )
    }
}


extension PlacesList: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Celda que vamos a pintar
        let cell = Bundle.main.loadNibNamed("PlaceTableViewCell", owner: self, options: nil)?.first as! PlaceTableViewCell
        
        // Datos del lugar con índice row
        let place = places[indexPath.row]
        
        // Asignamos los valores a la celda y devolvemos
        cell.placeImageView.image = place.image
        cell.placeNameLabel.text = place.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Se hizo clic sobre el lugar \(places[indexPath.row].name!)")
        // delegate?.didSelectCategory(categoryName: categories[indexPath.row].name)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 125 }
}

