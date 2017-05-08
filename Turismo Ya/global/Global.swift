//
//  Global.swift
//  Turismo Ya
//
//  Created by rimenri on 16/04/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit

class Global: NSObject {
    
    // Authenticated user
    static var user: User?
    static var authenticated: Bool = false
    
    static func setAuthenticatedUser(name: String, email: String) {
        self.user = User()
        self.user?.name = name
        self.user?.email = email
        self.authenticated = true
    }
    
    static func setAuthenticatedUser(user: User) {
        self.user = user
        self.authenticated = true
    }
    
    static func logoutUser() {
        self.user = nil
        self.authenticated = false
    }
    
    
    // ViewController titles & labels
    static var titleCategories: String {
        get {
            return parseTextByLang(str: "Categorías|Categories")
        }
    }
    static var titlePlaces: String {
        get {
            return parseTextByLang(str: "Lugares|Places")
        }
    }
    static var labelGuestUser: String {
        get {
            return parseTextByLang(str: "Usuario invitado|Guest user")
        }
    }
    static var labelLogout: String {
        get {
            return parseTextByLang(str: "Cerrar sesión|Logout")
        }
    }
    static var labelCity: String {
        get {
            return parseTextByLang(str: "Ciudad|City")
        }
    }
    static var labelShowMap: String {
        get {
            return parseTextByLang(str: "Ver mapa|Show map")
        }
    }
    static var labelHowArrive: String {
        get {
            return parseTextByLang(str: "Cómo llegar|How to arrive")
        }
    }
    static var labelLocation: String {
        get {
            return parseTextByLang(str: "Ubicación|Location")
        }
    }
    static var labelFavorite: String {
        get {
            return parseTextByLang(str: "Favorito|Favorite")
        }
    }
    static var labelStars: String {
        get {
            return parseTextByLang(str: "estrellas|stars")
        }
    }
    
    
    
    // Translation to EN / ES
    
    static var lang: String = "es"
    
    static func parseTextByLang(str: String) -> String {

        let textArray = str.components(separatedBy: "|")
        
        if textArray.count > 1 {
            if lang == "es" {
                return textArray[0]
            } else {
                return textArray[1]
            }
        } else {
            return str
        }
        
    }
    
    
    // Toast
    
    static func showToast(message : String, viewController: UIViewController) {
        let toastLabel = UILabel(frame: CGRect(x: viewController.view.frame.size.width/2 - 75, y: viewController.view.frame.size.height-100, width: 180, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        viewController.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    // Base URLs for API
    
    static let baseUrl: String = "http://52.170.87.192:50/premiun/modules/"
    
    static let urlContries: String = baseUrl + "aperturar.php?task=loadPais"
    static let urlRegister: String = baseUrl + "aperturar.php?task=createUser"
    static let urlLogin: String = baseUrl + "aperturar.php?task=loadNavegante"
    static let urlCities: String = baseUrl + "aperturar.php?task=loadCiudad"
    static let urlPlaces: String = baseUrl + "aperturar.php?task=loadProducto"
    
    static let urlAddFavorite: String = baseUrl + "aperturar.php?task=createFavorite" // &idnavegante=7&idproducto=2
    static let urlRemoveFavorite: String = baseUrl + "aperturar.php?task=createFavorite&opcion=3"
    static let urlGetFavorites: String = baseUrl + "aperturar.php?task=loadFavorito" // &idnavegante=7
    
    static let urlCreateQualification: String = baseUrl + "aperturar.php?task=createCalificacion" // &idnavegante=7&idproducto=3&calificacion=5
    static let urlGetQualification: String = baseUrl + "aperturar.php?task=loadCalificacion" // &idnavegante=7&idproducto=3
    
    static let urlGetComments: String = baseUrl + "aperturar.php?task=loadComentario" // &idproducto=3
    static let urlCreateComment: String = baseUrl + "aperturar.php?task=createComentario"
}
