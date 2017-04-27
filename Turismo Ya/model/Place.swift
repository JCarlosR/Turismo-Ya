//
//  Place.swift
//  Turismo Ya
//
//  Created by rimenri on 16/04/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
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
class Place: NSObject {
    var id: Int16 = 0
    var idSubLinea: Int16 = 0
    var idValoracion: Int16 = 0
    
    var _descripcion: String = ""
    var descripcion: String {
        get {
            return Global.parseTextByLang(str: _descripcion)
        }
    }
    var abrev: String = ""
    
    var telefono: String = ""
    var website: String = ""
    var address: String = ""
    var horaAbre: String = ""
    var horaCierra: String = ""
    var tenedor: String = ""
    
    var latitud: String = ""
    var longitud: String = ""
    
    var imageUrl: String = ""
}
