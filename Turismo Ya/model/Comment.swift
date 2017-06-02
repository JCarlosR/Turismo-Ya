import UIKit
import RealmSwift

class Comment: Object {
    dynamic var idComentario: String = ""
    dynamic var idNavegante: String = ""
    dynamic var navegante: String = ""
    dynamic var idProducto: String = ""
    dynamic var valor: String = ""
    dynamic var fecha: String = ""
    dynamic var comentario: String = ""
    
    override static func primaryKey() -> String? {
        return "idComentario"
    }
}
