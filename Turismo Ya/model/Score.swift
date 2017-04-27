//
//  Score.swift
//  Turismo Ya
//
//  Created by rimenri on 16/04/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit

class Score: NSObject {

    var id: Int16 = 0
    var _name: String = ""
    
    var name: String {
        get {
            return Global.parseTextByLang(str: _name)
        }
    }
    
    init(id: Int16, _name: String) {
        self.id = id
        self._name = _name
    }
    
}
