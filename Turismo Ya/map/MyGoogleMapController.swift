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

    var defaultZoom: Float = 13
    
    var markerTitle: String = ""
    
    var latitudeCenter: Double = -8.106525
    var longitudeCenter: Double = -79.02309
    
    var places: [Place] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let camera = GMSCameraPosition.camera(withLatitude: self.latitudeCenter,
                                                  longitude: self.longitudeCenter, zoom: self.defaultZoom)
        let mapView = GMSMapView.map(withFrame: rect, camera: camera)
        

        // just one location
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(self.latitudeCenter), longitude: Double(self.longitudeCenter))
        marker.snippet = self.markerTitle
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.map = mapView
            
        mapView.animate(toZoom: 15)
                
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
