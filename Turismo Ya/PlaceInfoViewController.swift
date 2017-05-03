//
//  PlaceInfoViewController.swift
//  Turismo Ya
//
//  Created by rimenri on 18/04/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import SDWebImage

class PlaceInfoViewController: UIViewController {

    @IBOutlet weak var topBtnHowArrrive: UIImageView!
    @IBOutlet weak var topBtnLocation: UIImageView!
    @IBOutlet weak var topBtnStar: UIImageView!
    
    
    @IBOutlet weak var topLabelHowArrive: UILabel!
    @IBOutlet weak var topLabelLocation: UILabel!
    @IBOutlet weak var topLabelFavorite: UILabel!
    
    @IBOutlet weak var imageViewPlace: UIImageView!
    @IBOutlet weak var labelTitlePlace: UILabel!
    @IBOutlet weak var labelDescriptionPlace: UILabel!
        
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelStars: UILabel!
    
    var place: Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let place = place {
            self.title = place.abrev

            labelTitlePlace.text = place.abrev
            labelDescriptionPlace.text = place.descripcion
            
            let imageUrl = URL(string: "http://52.170.87.192:50/premiun/images/producto/\(place.imageUrl)")
            imageViewPlace.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "logo.png"), options: SDWebImageOptions.progressiveDownload)
            
            
            labelAddress.text = place.address
            labelPhone.text = place.telefono
            labelStars.text = "\(place.idValoracion) \(Global.labelStars)"
            
            
            // button text translation
            topLabelHowArrive.text = Global.labelHowArrive
            topLabelLocation.text = Global.labelLocation
            topLabelFavorite.text = Global.labelFavorite
            
            
            // click events
            
            let howArriveEvent = UITapGestureRecognizer(target: self, action: #selector(PlaceInfoViewController.clickedTopBtnHowArrive))
            topBtnHowArrrive.addGestureRecognizer(howArriveEvent)
            topBtnHowArrrive.isUserInteractionEnabled = true
            
            let locationEvent = UITapGestureRecognizer(target: self, action: #selector(PlaceInfoViewController.clickedTopBtnLocation))
            topBtnLocation.addGestureRecognizer(locationEvent)
            topBtnLocation.isUserInteractionEnabled = true
            
            let starEvent = UITapGestureRecognizer(target: self, action: #selector(PlaceInfoViewController.clickedTopBtnStar))
            topBtnStar.addGestureRecognizer(starEvent)
            topBtnStar.isUserInteractionEnabled = true
        }
        
    }
    
    func clickedTopBtnHowArrive() {
        let myUrlString: String = "https://www.google.com/maps/dir/Current+Location/\(place?.latitud ?? ""),\(place?.longitud ?? "")"
        let url = URL(string: myUrlString.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func clickedTopBtnLocation() {
        /*let secondViewController:MyGoogleMapController = MyGoogleMapController()
        
        secondViewController.latitudeCenter = Double((place?.latitud)!)!
        secondViewController.longitudeCenter = Double((place?.longitud)!)!
        secondViewController.markerTitle = (place?.abrev)!
        
        self.present(secondViewController, animated: true, completion: nil)*/
        
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "myGoogleMapController") as! MyGoogleMapController
        VC1.latitudeCenter = Double((place?.latitud)!)!
        VC1.longitudeCenter = Double((place?.longitud)!)!
        VC1.markerTitle = (place?.abrev)!
        VC1.defaultZoom = 17
        self.navigationController!.pushViewController(VC1, animated: true)
    }
    
    func clickedTopBtnStar() {
        Global.showToast(message: "Agregado a favoritos", viewController: self)
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
