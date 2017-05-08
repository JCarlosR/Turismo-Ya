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
    var id: Int16 = 0
    var _name: String = ""
    var name: String {
        get {
            return Global.parseTextByLang(str: self._name)
        }
    }
    var latitude: Float = 0
    var longitude: Float = 0
    var imageUrl: String = ""
}
