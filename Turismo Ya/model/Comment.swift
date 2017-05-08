//
//  Comment.swift
//  Turismo Ya
//
//  Created by rimenri on 05/05/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import RealmSwift

class Comment: Object {
    var idComentario: String = ""
    var idNavegante: String = ""
    var navegante: String = ""
    var idProducto: String = ""
    var valor: String = ""
    var fecha: String = ""
    var comentario: String = ""
}
