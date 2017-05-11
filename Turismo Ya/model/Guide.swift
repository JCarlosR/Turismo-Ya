//
//  Guide.swift
//  Turismo Ya
//
//  Copyright © 2017 Programación y más. All rights reserved.
//

/*
{
 "idGuia":"5",
 "Nombre":"Maritza Violeta Cabanillas Vasquez",
 "Sexo":"F",
 "Ruc":"10180567840",
 "Dni":"18056784",
 "Idioma":"1|2","
 Telefono":"949968077",
 "Email":"maritzavioleta2003@yahoo.es",
 "FechaExpedicion":"2017\/05\/05",
 "Activo":"1"
}
*/

import UIKit
import RealmSwift

class Guide: Object {
    var idGuia: String = ""
    var nombre: String = ""
    var sexo: String = ""
    var ruc: String = ""
    var dni: String = ""
    var idioma: String = ""
    var telefono: String = ""
    var email: String = ""
    // var fechaExpedicion: String = ""
}
