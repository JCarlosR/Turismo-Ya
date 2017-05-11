//
//  Language.swift
//  Turismo Ya
//
//  Created by rimenri on 10/05/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import RealmSwift

class Language: Object {
    var idIdiomaGuia: String = ""
    var _descripcion: String = ""
    var descripcion: String {
        get {
            return Global.parseTextByLang(str: self._descripcion)
        }
    }
}
