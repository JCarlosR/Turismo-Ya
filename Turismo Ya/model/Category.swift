//
//  Category.swift
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit

/*
{
 "idLinea":"1",
 "Descripcion":"DONDE COMER",
 "Imagen":"cat_restaurante.jpg"
}*/
class Category: NSObject {
    var id: Int16 = 0
    var _name: String = ""
    var name: String {
        get {
            return Global.parseTextByLang(str: self._name)
        }
    }
    var imageUrl: String = ""
}
