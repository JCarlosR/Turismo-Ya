//
//  Category.swift
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import RealmSwift
/*
{
 "idLinea":"1",
 "Descripcion":"DONDE COMER",
 "Imagen":"cat_restaurante.jpg"
}*/
class Category: Object {
    dynamic var id: Int16 = 0
    dynamic var _name: String = ""
    var name: String {
        get {
            return Global.parseTextByLang(str: self._name)
        }
    }
    dynamic var imageUrl: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
