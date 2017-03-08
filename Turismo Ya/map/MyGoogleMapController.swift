//
//  MyGoogleMapController.swift
//  Turismo Ya
//
//  Created by rimenri on 28/02/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import GoogleMaps

class MyGoogleMapController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.868,
                                                          longitude:151.2086, zoom:6)
        let mapView = GMSMapView.map(withFrame: rect, camera:camera)
        
        let marker = GMSMarker()
        marker.position = camera.target
        marker.snippet = "Hello World"
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.map = mapView
        
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
