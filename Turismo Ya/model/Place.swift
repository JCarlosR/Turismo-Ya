//
//  Place.swift
//  Turismo Ya
//
//  Created by rimenri on 16/04/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import RealmSwift
/*
{
 "idProducto":"1",
 "idSubLinea":"1",
 "idValoracion":"3",
 "Descripcion":"Deliciosos platillos, para los paladares mas exigentes|Delicious dishes for the most demanding palates",
 "Abrev":"CASA ANDINA",
 "Telefono":"987655485",
 "Website":"www.google.com",
 "Direccion":"Av brasil",
 "HoraAbierto":"9:00 am",
 "HoraCierre":"5:00 pm",
 "Tenedor":"5 ",
 "Latitud":"-8.1065258","Altitud":"-79.023090100000005",
 "Imagen":"r_casa_andina_0.jpg"
}
*/
class Place: Object {
    dynamic var id: Int16 = 0
    dynamic var idLinea: String = ""
    dynamic var idSubLinea: Int16 = 0
    dynamic var idValoracion: Int16 = 0
    
    dynamic var _descripcion: String = ""
    var descripcion: String {
        get {
            return Global.parseTextByLang(str: _descripcion)
        }
    }
    dynamic var abrev: String = ""
    
    dynamic var telefono: String = ""
    dynamic var website: String = ""
    dynamic var address: String = ""
    dynamic var horaAbre: String = ""
    dynamic var horaCierra: String = ""
    dynamic var tenedor: String = ""
    
    dynamic var latitud: String = ""
    dynamic var longitud: String = ""
    
    dynamic var imageUrl: String = ""
    
    dynamic var idCiudad: String = ""
    dynamic var ruc: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
