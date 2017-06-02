//  TouristGuideList.swift
//  Copyright © 2017 Programación y más. All rights reserved.

import UIKit

class TouristGuideList: NSObject {
    
    // weak var delegate: ShowPlacesDelegate?
    
    var tableViewTouristGuide: UITableView?
    
    var guides: [Guide] = []
    var filteredGuides: [Guide] = []
    
    func addGuide(guide: Guide) {
        guides.append(guide)
    }
    
    func clearGuides() {
        guides.removeAll()
    }
    
    func applyFilter(idIdioma: String) {
        filteredGuides.removeAll()
        for guide in guides {
            let idiomas: [String] = guide.idioma.components(separatedBy: "|")
            if idiomas.contains(idIdioma) {
                filteredGuides.append(guide)
            }
        }
    }
}
/*
protocol ShowPlacesDelegate: class {
    func didSelectCategory(categoryId: Int16)
}*/

extension TouristGuideList: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGuides.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Celda que vamos a pintar
        let cell = Bundle.main.loadNibNamed("GuideTableViewCell", owner: self, options: nil)?.first as! GuideTableViewCell
        
        // Datos del guía con índice row
        let guide = filteredGuides[indexPath.row]
        
        // Asignamos los valores a la celda y la devolvemos luego
        if guide.sexo == "F" {
            cell.imageViewSexo.image = UIImage(named: "female-icon.png")
        } else {
            cell.imageViewSexo.image = UIImage(named: "male-icon.png")
        }
        
        cell.labelName.text = guide.nombre
        cell.labelPhone.text = guide.telefono
        
        return cell
        
        // Custom table view tutorial: https://www.youtube.com/watch?v=zAWO9rldyUE
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print("Mostrar detalles del guía \(filteredGuides[indexPath.row].name)")
        // delegate?.didSelectCategory(categoryId: categories[indexPath.row].id)
    }
    
    
}
