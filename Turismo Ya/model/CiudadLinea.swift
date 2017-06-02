//  CiudadLinea.swift
//  Turismo Ya

//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import RealmSwift

class CiudadLinea: Object {
    dynamic var idCiudad: String = ""
    dynamic var idLinea: String = ""
    // the rows will be deleted and re-created when there is an internet connection
}
