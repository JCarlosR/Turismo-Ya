//
//  City.swift
//  Turismo Ya
//
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit

/*
 {
 "idCiudad":"1",
 "Descripcion":"TRUJILLO",
 "Activo":"1",
 "Latitud":"-8.1117457033549183",
 "Altitud":"-79.028778076171875",
 "Imagen":null
 }
*/
import RealmSwift

class City: Object {
    dynamic var id: Int16 = 0
    dynamic var _name: String = ""
    dynamic var name: String {
        get {
            return Global.parseTextByLang(str: self._name)
        }
    }
    dynamic var latitude: Float = 0
    dynamic var longitude: Float = 0
    dynamic var imageUrl: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
