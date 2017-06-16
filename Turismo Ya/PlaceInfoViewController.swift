//
//  PlaceInfoViewController.swift
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import RealmSwift

class PlaceInfoViewController: UIViewController {

    @IBOutlet weak var topBtnHowArrrive: UIImageView!
    @IBOutlet weak var topBtnLocation: UIImageView!
    @IBOutlet weak var topBtnStar: UIImageView!
    
    @IBOutlet weak var topLabelHowArrive: UILabel!
    @IBOutlet weak var topLabelLocation: UILabel!
    @IBOutlet weak var topLabelFavorite: UILabel!
    
    var isFavorite: Bool = false
    
    @IBOutlet weak var imageViewPlace: UIImageView!
    @IBOutlet weak var labelTitlePlace: UILabel!
    @IBOutlet weak var labelDescriptionPlace: UILabel!
        
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelStars: UILabel!
    
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    let imageStarOn = UIImage(named:"star-on.png")
    let imageStarOff = UIImage(named:"star-off.png")
    
    var place: Place?
    
    
    var commentList = CommentList()
    @IBOutlet weak var tableViewComments: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // remove blank top from table view
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        // hide footer initially (we will check if  the user has commented)
        // if there is not an authenticated user, it will stay hidden
        self.tableViewComments.tableFooterView?.isHidden = true
                
        loadCurrentQualification()
        checkIfFavorite()
        
        star1.setImage(imageStarOff, for: .normal)
        star2.setImage(imageStarOff, for: .normal)
        star3.setImage(imageStarOff, for: .normal)
        star4.setImage(imageStarOff, for: .normal)
        star5.setImage(imageStarOff, for: .normal)
        
        loadComments()
        
        if let place = place {
            self.title = place.abrev

            labelTitlePlace.text = place.abrev
            labelDescriptionPlace.text = place.descripcion
            
            let imageUrl = URL(string: Global.imageBasePath + "producto/\(place.imageUrl)")
            imageViewPlace.sd_setImage(with: imageUrl, placeholderImage: Global.defaultPlaceholder, options: SDWebImageOptions.progressiveDownload)
            
            
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
            
            // keyboard events
            NotificationCenter.default.addObserver(self, selector: #selector(PlaceInfoViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(PlaceInfoViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
        // Show Google Maps
        
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "myGoogleMapController") as! MyGoogleMapController
        VC1.latitudeCenter = Double((place?.latitud)!)!
        VC1.longitudeCenter = Double((place?.longitud)!)!
        VC1.markerTitle = (place?.abrev)!
        VC1.defaultZoom = 17
        self.navigationController!.pushViewController(VC1, animated: true)
    }
    
    
    // Add / remove favorites
    func clickedTopBtnStar() {
        if Global.authenticated {
            var targetUrl: String = ""
            
            if self.isFavorite {
                targetUrl = Global.urlRemoveFavorite
            } else {
                targetUrl = Global.urlAddFavorite
            }
            targetUrl = targetUrl + "&idnavegante=\(Global.user!.id)&idproducto=\(self.place?.id ?? 0)"
            
            Alamofire.request(targetUrl)
                .responseJSON { response in
                    // debugPrint(response)
                    if let result = response.result.value {
                        let responseCode: Int16 =  result as! Int16
                        // print("Response code for add/remove favorites: \(responseCode)")
                    
                        if responseCode == 1 {
                            if self.isFavorite {
                                self.isFavorite = false
                                self.topBtnStar.image = self.imageStarOff
                            } else {
                                self.isFavorite = true
                                self.topBtnStar.image = self.imageStarOn
                            }
                            Global.showToast(message: "Favoritos actualizados", viewController: self)
                            
                        } else {
                            Global.showToast(message: "Rpta del servidor desconocida", viewController: self)
                        }
                        
                    }
            }
        } else {
            Global.showToast(message: "Debes iniciar sesión", viewController: self)
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Qualification
    
    func loadCurrentQualification() {
        if Global.authenticated {
            let params: String = "&idnavegante=\(Global.user?.id ?? "0")&idproducto=\(self.place?.id ?? 0)"
            Alamofire.request(Global.urlGetQualification + params)
                .responseJSON { response in
                    // debugPrint(response)
                    
                    if let result = response.result.value {
                        let arrayData: NSArray = result as! NSArray
                        for qData: NSDictionary in arrayData as! [NSDictionary] {
                            
                            let qualification = Qualification()
                            qualification.idNavegante = qData["idNavegante"]! as! String
                            qualification.idProducto = qData["idProducto"]! as! String
                            qualification.Calificacion = Int8(qData["Calificacion"]! as! String)!
                            
                            self.paintStarsUpTo(stars: qualification.Calificacion)
                        }
                    }
            }
        }
    }
    
    @IBAction func star1pressed(_ sender: Any) {
        performRequestQualification(stars: 1)
    }
    @IBAction func star2pressed(_ sender: Any) {
        performRequestQualification(stars: 2)
    }
    @IBAction func star3pressed(_ sender: Any) {
        performRequestQualification(stars: 3)
    }
    @IBAction func star4pressed(_ sender: Any) {
        performRequestQualification(stars: 4)
    }
    @IBAction func star5pressed(_ sender: Any) {
        performRequestQualification(stars: 5)
    }
    
    func performRequestQualification(stars: Int8) {
        if !Global.authenticated {
            Global.showToast(message: "Debe iniciar sesión", viewController: self)
            return
        }
        
        let params: String = "&idnavegante=\(Global.user!.id)&idproducto=\(self.place!.id)&calificacion=\(stars)"
        Alamofire.request(Global.urlCreateQualification + params)
            .responseJSON { response in
                // debugPrint(response)
                
                if let result = response.result.value {
                    let responseCode: Int8 =  result as! Int8
                    // print("Response code for qualification: \(responseCode)")
                    
                    if responseCode == 1 {
                        self.paintStarsUpTo(stars: stars)
                        Global.showToast(message: "Calificación registrada", viewController: self)
                    } else {
                        Global.showToast(message: "Rpta del servidor desconocida", viewController: self)
                    }
                    
                }
        }
    }
    
    func paintStarsUpTo(stars: Int8) {
        if (stars >= 1) {
            star1.setImage(imageStarOn, for: .normal)
        } else {
            star1.setImage(imageStarOff, for: .normal)
        }
        
        if (stars >= 2) {
            star2.setImage(imageStarOn, for: .normal)
        } else {
            star2.setImage(imageStarOff, for: .normal)
        }
        
        if (stars >= 3) {
            star3.setImage(imageStarOn, for: .normal)
        } else {
            star3.setImage(imageStarOff, for: .normal)
        }
        
        if (stars >= 4) {
            star4.setImage(imageStarOn, for: .normal)
        } else {
            star4.setImage(imageStarOff, for: .normal)
        }
        
        if (stars == 5) {
            star5.setImage(imageStarOn, for: .normal)
        } else {
            star5.setImage(imageStarOff, for: .normal)
        }
        
    }
    
    
    // Favorite
    
    func checkIfFavorite() {
        if Global.authenticated {
         
            var favorites: [Favorite] = []
            Alamofire.request(Global.urlGetFavorites+"&idnavegante=\(Global.user?.id ?? "")").responseJSON { response in
                
                if let result = response.result.value {
                    let placesData: NSArray = result as! NSArray
                    for placeData: NSDictionary in placesData as! [NSDictionary] {
                        
                        let favorite = Favorite()
                        favorite.idNavegante = Int16(placeData["idNavegante"]! as! String)!
                        favorite.idProducto = Int16(placeData["idProducto"]! as! String)!
                        
                        favorites.append(favorite)
                    }
                    
                    for favorite in favorites {
                        if self.place?.id == favorite.idProducto {
                            self.topBtnStar.image = self.imageStarOn
                            self.isFavorite = true
                        }
                    }
                }
            }
            
        }
    }

    
    // MARK: - Comments

    func loadComments() {
        // setup table view
        tableViewComments.dataSource = commentList
        tableViewComments.delegate = commentList
        
        let realm = try! Realm()
        
        if !Connectivity.isConnectedToInternet() {
            // read from local data
            // print("read Comment objects from realm")
            let comments = realm.objects(Comment.self).filter("idProducto = '\(self.place?.id ?? 0)'")
            
            self.commentList.comments = Array(comments)
            self.tableViewComments.reloadData()
            
            self.hideFooterIfTheUserHasAlreadyCommented()
            
            return
        }
        
        let params: String = "&idproducto=\(self.place?.id ?? 0)"
        Alamofire.request(Global.urlGetComments + params).responseJSON { response in
            
            // print("Comments result:", response.result)
            if let result = response.result.value {
                self.commentList.clearComments()
         
                let arrayData: NSArray = result as! NSArray
                for commentData: NSDictionary in arrayData as! [NSDictionary] {
                    let comment = Comment()
                    
                    comment.idComentario = commentData["idComentario"]! as! String
                    comment.idNavegante = commentData["idNavegante"]! as! String
                    comment.idProducto = commentData["idProducto"]! as! String
                    comment.navegante = commentData["Navegante"]! as! String
                    comment.valor = commentData["Valor"]! as! String
                    comment.fecha = commentData["Fecha"]! as! String
                    comment.comentario = commentData["Comentario"]! as! String
                    
                    self.commentList.addComment(comment: comment)
                }
                self.tableViewComments.reloadData()
                
                self.hideFooterIfTheUserHasAlreadyCommented()
                
                // persist data
                try! realm.write {
                    for comment in self.commentList.comments {
                        realm.add(comment, update: true)
                    }
                }
            }
        }
        
    }
    
    func hideFooterIfTheUserHasAlreadyCommented() {
        // check if the authenticated user has commented previously
        var userHasCommented: Bool = false
        if Global.authenticated {
            for comment in self.commentList.comments {
                if comment.idNavegante == Global.user?.id {
                    userHasCommented = true
                    break
                }
            }
            self.tableViewComments.tableFooterView?.isHidden = userHasCommented
        }
    }
    
    @IBOutlet weak var txtComment: UITextField!
    
    @IBAction func btnSendCommentPressed(_ sender: Any) {
        if !Global.authenticated {
            return
        }
        
        let comment: String = txtComment.text!
        if comment.characters.count < 4 {
            Global.showToast(message: "Comentario muy corto", viewController: self)
            return
        }
        
        var params: String = "&idnavegante=\(Global.user!.id)&idproducto=\(self.place!.id)&comentario=\(comment)"
        params = params.addingPercentEncoding(
            withAllowedCharacters: NSCharacterSet.urlFragmentAllowed)!
        Alamofire.request(Global.urlCreateComment + params)
            .responseJSON { response in
                // debugPrint(response)
                if let result = response.result.value {
                    let responseCode: Int16 =  result as! Int16
                    // print("Response code for create comment: \(responseCode)")
                    
                    if responseCode == 1 {
                        self.loadComments()
                        self.txtComment.text = ""
                        self.tableViewComments.tableFooterView?.isHidden = true
                        self.view.endEditing(true)
                    } else {
                        Global.showToast(message: "Rpta del servidor desconocida", viewController: self)
                    }
                }
        }
    }
    
    
    // MARK: - Keyboard events
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}
