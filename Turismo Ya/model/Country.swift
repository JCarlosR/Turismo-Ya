//
//  Country.swift
//  Turismo Ya
//
//  Created by rimenri on 30/04/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit

class Country: NSObject {
    var idPais: String = ""
    var _descripcion: String = ""
    var descripcion: String {
        get {
            return Global.parseTextByLang(str: self._descripcion)
        }
    }
}
