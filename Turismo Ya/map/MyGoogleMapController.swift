//
//  MyGoogleMapController.swift
//  Turismo Ya
//
//  Created by rimenri on 28/02/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

class MyGoogleMapController: UIViewController {

    var selectedCategoryId: Int16 = 0
    var defaultZoom: Float = 13
    
    var markerTitle: String = ""
    
    var latitudeCenter: Double = -8.106525
    var longitudeCenter: Double = -79.02309
    
    var places: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        var camera = GMSCameraPosition.camera(withLatitude: self.latitudeCenter,
                                                  longitude: self.longitudeCenter, zoom: self.defaultZoom)
        let mapView = GMSMapView.map(withFrame: rect, camera: camera)
        
        if self.selectedCategoryId != 0 {
            Alamofire.request("http://52.170.87.192:50/premiun/modules/aperturar.php?task=loadProducto").responseJSON { response in
                
                print("Places result:", response.result)   // result of response serialization
                
                if let result = response.result.value {
                    let placesData: NSArray = result as! NSArray
                    for placeData: NSDictionary in placesData as! [NSDictionary] {
                        let place = Place()
                        place.id = Int16(placeData["idProducto"]! as! String)!
                        place.idSubLinea = Int16(placeData["idSubLinea"]! as! String)!
                        place.abrev = placeData["Abrev"]! as! String
                        place.idValoracion = Int16(placeData["idValoracion"]! as! String)!
                        place._descripcion = placeData["Descripcion"]! as! String
                        place.telefono = placeData["Telefono"]! as! String
                        place.website = placeData["Website"]! as! String
                        place.address = placeData["Direccion"]! as! String
                        
                        place.horaAbre = placeData["HoraAbierto"]! as! String
                        place.horaCierra = placeData["HoraCierre"]! as! String
                        place.tenedor = placeData["Tenedor"]! as! String
                        
                        place.latitud = placeData["Latitud"]! as! String
                        place.longitud = placeData["Altitud"]! as! String
                        place.imageUrl = placeData["Imagen"]! as! String
                        
                        self.places.append(place)
                    }
                    
                    if self.places.count > 0 {
                        self.latitudeCenter = Double(self.places[0].latitud)!
                        self.longitudeCenter = Double(self.places[0].longitud)!
                        camera = GMSCameraPosition.camera(withLatitude: self.latitudeCenter,
                                                          longitude: self.longitudeCenter, zoom: self.defaultZoom)
                        mapView.animate(to: camera)
                    }
                    
                    for place in self.places {
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: Double(place.latitud)!, longitude: Double(place.longitud)!)
                        marker.snippet = place.abrev
                        marker.appearAnimation = GMSMarkerAnimation.pop
                        marker.map = mapView
                    }
                }
            }
        } else {
            // just one location
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: Double(self.latitudeCenter), longitude: Double(self.longitudeCenter))
            marker.snippet = self.markerTitle
            marker.appearAnimation = GMSMarkerAnimation.pop
            marker.map = mapView
            
            mapView.animate(toZoom: 15)
        }
        
        
        self.view = mapView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
