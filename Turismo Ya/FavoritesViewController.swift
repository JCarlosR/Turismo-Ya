//
//  FavoritesViewController.swift
//  Turismo Ya
//
//  Created by rimenri on 03/05/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class FavoritesViewController: UITableViewController {

    var favorites: [Favorite] = []
    var allPlaces: [Place] = []
    var places: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Alamofire.request(Global.urlPlaces).responseJSON { response in
            
            // print("Places result:", response.result)
            if let result = response.result.value {
                let placesData: NSArray = result as! NSArray
                for placeData: NSDictionary in placesData as! [NSDictionary] {
                    let place = Place()
                    place.id = Int16(placeData["idProducto"]! as! String)!
                    place.idSubLinea = Int16(placeData["idSubLinea"]! as! String)!
                    place.abrev = placeData["Abrev"] as? String ?? ""
                    place.idValoracion = Int16(placeData["idValoracion"]! as! String)!
                    place._descripcion = placeData["Descripcion"] as? String ?? ""
                    place.telefono = placeData["Telefono"] as? String ?? ""
                    place.website = placeData["Website"] as? String ?? ""
                    place.address = placeData["Direccion"] as? String ?? ""
                    
                    place.horaAbre = placeData["HoraAbierto"] as? String ?? ""
                    place.horaCierra = placeData["HoraCierre"] as? String ?? ""
                    place.tenedor = placeData["Tenedor"] as? String ?? ""
                    
                    place.latitud = placeData["Latitud"] as? String ?? ""
                    place.longitud = placeData["Altitud"] as? String ?? ""
                    place.imageUrl = placeData["Imagen"] as? String ?? ""
                    
                    self.allPlaces.append(place)
                }
                
                // Load favorites
                if Global.authenticated {
                    self.loadFavorites()
                }
                
                self.tableView.reloadData()
            }
        }
    }

    func loadFavorites() {
        Alamofire.request(Global.urlGetFavorites+"&idnavegante=\(Global.user?.id ?? "")").responseJSON { response in
            
            if let result = response.result.value {
                let placesData: NSArray = result as! NSArray
                for placeData: NSDictionary in placesData as! [NSDictionary] {
                    
                    let favorite = Favorite()
                    favorite.idNavegante = Int16(placeData["idNavegante"]! as! String)!
                    favorite.idProducto = Int16(placeData["idProducto"]! as! String)!
                    
                    self.favorites.append(favorite)
                }
             
                for place in self.allPlaces {
                    // var isFavoritePlace = false
                    for favorite in self.favorites {
                        if place.id == favorite.idProducto {
                            self.places.append(place)
                        }
                    }
                }
                
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Celda que vamos a pintar
        let cell = Bundle.main.loadNibNamed("PlaceTableViewCell", owner: self, options: nil)?.first as! PlaceTableViewCell
        
        // Datos del lugar con índice row
        let place = places[indexPath.row]
        
        // Asignamos los valores a la celda y devolvemos
        let imageUrl = URL(string: Global.imageBasePath + "producto/\(place.imageUrl)")
        cell.placeImageView.sd_setImage(with: imageUrl, placeholderImage: Global.defaultPlaceholder, options: SDWebImageOptions.progressiveDownload)
        cell.placeNameLabel.text = place.abrev
        cell.placeDescriptionLabel.text = place.descripcion
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print("Se hizo clic sobre el lugar \(places[indexPath.row].abrev)")
        self.selectedPlace = places[indexPath.row]
        performSegue(withIdentifier: "showFavoriteInfoSegue", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 125 }

    
    // MARK: - Show info place
    var selectedPlace: Place?
    
    // pass parameters via segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFavoriteInfoSegue" {
            if let destinationVC = segue.destination as? PlaceInfoViewController {
                destinationVC.place = self.selectedPlace
            }
        }
    }

}
