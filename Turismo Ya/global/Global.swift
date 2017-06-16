//
//  Global.swift
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
    
    
    // Global variables
    static var selectedCityId: Int16 = 1 // City 1 is ALL
    // Global constants
    static let defaultPlaceholder: UIImage = #imageLiteral(resourceName: "camarita.jpg")
    
    
    // Images URL
    static let imageBasePath: String = "http://40.71.226.62:50/ProgramaAdministrativoCopia/images/"
    static let imageUrlWelcome: String = "http://www.regionlalibertad.gob.pe/images/autoridades/lvaldez.jpg"
    
    
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
    // labels in side menu:
    static var labelGuestUser: String {
        get {
            return parseTextByLang(str: "Usuario invitado|Guest user")
        }
    }
    static var labelFavorites: String {
        get {
            return parseTextByLang(str: "Mis favoritos|My favorites")
        }
    }
    static var labelWelcomeMessage: String {
        get {
            return parseTextByLang(str: "Mensaje de bienvenida|Welcome message")
        }
    }
    static var labelTouristGuide: String {
        get {
            return parseTextByLang(str: "Guía turística|Touist guide")
        }
    }
    static var labelLogout: String {
        get {
            return parseTextByLang(str: "Cerrar sesión|Logout")
        }
    }
    // labels in view controllers:
    static var labelWelcomeTitle: String {
        get {
            return parseTextByLang(str: "Bienvenido a la Región La Libertad|Welcome to the Region La Libertad")
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
    static var labelLanguage: String {
        get {
            return parseTextByLang(str: "Lenguaje|Language")
        }
    }
    static var labelLinkDownloadList: String {
        get {
            return parseTextByLang(str: "Lista general|General list")
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
    
    static let baseUrl: String = "http://40.71.226.62:50/ProgramaAdministrativoCopia/modules/"
    
    static let urlContries: String = baseUrl + "aperturar.php?task=loadPais"
    static let urlRegister: String = baseUrl + "aperturar.php?task=createUser"
    static let urlLogin: String = baseUrl + "aperturar.php?task=loadNavegante"
    static let urlCities: String = baseUrl + "aperturar.php?task=loadCiudad"
    static let urlCategories: String = baseUrl + "aperturar.php?task=loadLinea"
    static let urlCityCategoryRelations: String = baseUrl + "aperturar.php?task=loadCiudadLinea"
    static let urlCityPlaceRelations: String = baseUrl + "aperturar.php?task=loadCiudadProducto"
    static let urlTypes: String = baseUrl + "aperturar.php?task=loadSubLinea"
    static let urlPlaces: String = baseUrl + "aperturar.php?task=loadProducto"
    static let urlParameterWelcomeMessage: String = baseUrl + "aperturar.php?task=loadParametro&idparametro=73"
    
    static let urlAddFavorite: String = baseUrl + "aperturar.php?task=createFavorite" // &idnavegante=7&idproducto=2
    static let urlRemoveFavorite: String = baseUrl + "aperturar.php?task=createFavorite&opcion=3"
    static let urlGetFavorites: String = baseUrl + "aperturar.php?task=loadFavorito" // &idnavegante=7
    
    static let urlCreateQualification: String = baseUrl + "aperturar.php?task=createCalificacion" // &idnavegante=7&idproducto=3&calificacion=5
    static let urlGetQualification: String = baseUrl + "aperturar.php?task=loadCalificacion" // &idnavegante=7&idproducto=3
    
    static let urlGetComments: String = baseUrl + "aperturar.php?task=loadComentario" // &idproducto=3
    static let urlCreateComment: String = baseUrl + "aperturar.php?task=createComentario"
    
    static let urlLanguages: String = baseUrl + "aperturar.php?task=loadIdiomaGuia"
    static let urlTouristGuide: String = baseUrl + "aperturar.php?task=loadGuiaTuristica"
    
}
