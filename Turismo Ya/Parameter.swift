//
//  Parameter.swift
//  Turismo Ya
//  Copyright © 2017 Programación y más. All rights reserved.

import UIKit
import RealmSwift

class Parameter: Object {
    dynamic var idParametro: String = ""
    dynamic var nombre: String = ""
    dynamic var valor: String = ""
    
    override static func primaryKey() -> String? {
        return "idParametro"
    }
}
