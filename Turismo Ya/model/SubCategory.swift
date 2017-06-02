import UIKit
import RealmSwift

/*
 {"idSubLinea":"1","idLinea":"1","Abrev":"CARNES|MEATS","Descripcion":"CARNES|MEATS","Imagen":"-","Activo":"1"}
 */

class SubCategory: Object {
    dynamic var id: Int16 = 0
    dynamic var idLinea: String = "" // category
    dynamic var _name: String = ""
    
    /*var name: String {
        get {
            return Global.parseTextByLang(str: self._name)
        }
    }*/
    
    func getName() -> String {
        return Global.parseTextByLang(str: self._name)
    }
    
    dynamic var imageUrl: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
