//  Language.swift
//  Copyright © 2017 Programación y más. All rights reserved.

import UIKit
import RealmSwift

class Language: Object {
    dynamic var idIdiomaGuia: String = ""
    dynamic var _descripcion: String = ""
    var descripcion: String {
        get {
            return Global.parseTextByLang(str: self._descripcion)
        }
    }
    
    override static func primaryKey() -> String? {
        return "idIdiomaGuia"
    }
}
