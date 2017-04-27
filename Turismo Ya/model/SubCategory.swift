import UIKit

/*
 {"idSubLinea":"1","idLinea":"1","Abrev":"CARNES|MEATS","Descripcion":"CARNES|MEATS","Imagen":"-","Activo":"1"}
 */

class SubCategory: NSObject {
    var id: Int16 = 0
    var _name: String = ""
    var name: String {
        get {
            return Global.parseTextByLang(str: self._name)
        }
    }
    var imageUrl: String = ""
}
