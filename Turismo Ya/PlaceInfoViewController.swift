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
            labelStars.text = "\(place.idValoracion) estrellas"
            
            
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
        showToast(message: "Agregado a favoritos")
    }
    
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 180, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
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
