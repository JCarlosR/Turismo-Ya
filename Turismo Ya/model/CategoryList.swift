//
//  CategoryList.swift
//  Turismo Ya
//
//  Created by rimenri on 22/02/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import SDWebImage

struct Category {
    // let cell: Int!
    let name: String!
    let image: String
}

class CategoryList: NSObject {
    
    weak var delegate: ShowPlacesDelegate?
    
    var categoriesTableView: UITableView?
    
    var categories: [Category] = []
    
    func addCategory(categoryName: String, categoryImageUrl: String) {
        categories.append(
            Category(
                // cell: 1,
                name: categoryName,
                image: categoryImageUrl
            )
        )
    }
    
}

protocol ShowPlacesDelegate: class {
    func didSelectCategory(categoryName: String)
}

protocol OpenMapDelegate: class {
    func openMapView()
}

extension CategoryList: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Celda que vamos a pintar
        // let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cell = Bundle.main.loadNibNamed("CategoryTableViewCell", owner: self, options: nil)?.first as! CategoryTableViewCell
        
        // Datos de la categoría con índice row
        let category = categories[indexPath.row]
        
        // Asignamos los valores a la celda y la devolvemos luego
        
        // cell.textLabel!.text = categoryName
        // cell.categoryImageView.image = category.image
        let imageUrl = URL(string: category.image)
        cell.categoryImageView.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "pajaro azul"), options: SDWebImageOptions.progressiveDownload)
        cell.categoryNameLabel.text = category.name
        cell.delegate = delegate as! OpenMapDelegate? // the same instance implements both protocols
        
        return cell
        
        // Podemos incluso usar 2 formatos distintos de tableViewCell
        // para ello, en base a 1 atributo cell podemos decidir qué nib vamos a usar
        // Custom table view tutorial: https://www.youtube.com/watch?v=zAWO9rldyUE
        // Si estos nib tienen alturas distintas, entonces hay que sobreescribir un método más
        // en esta implementaciìn de UITableViewDataSource, para tener acceso a definir
        // la altura de nuestras celdas, en base al nib escogido (según el valor de cell)
        // Podemos usar cualquier nombre, cell es solo un ejemplo. Basta que sea una var que represente
        // al tipo de celda.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // A diferencia de print, NSLog permite mostrar mensajes en consola incluso desde otros hilos
        print("Mostrar detalles de la categoría \(categories[indexPath.row].name!)")
        delegate?.didSelectCategory(categoryName: categories[indexPath.row].name)
    }
    
    
}


