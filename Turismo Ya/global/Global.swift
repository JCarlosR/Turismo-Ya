//
//  Global.swift
//  Turismo Ya
//
//  Created by rimenri on 16/04/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit

class Global: NSObject {
    
    static var lang: String = "es"
    
    static func parseTextByLang(str: String) -> String {

        let textArray = str.components(separatedBy: "|")
        if lang == "es" {
            return textArray[0]
        } else {
            return textArray[1]
        }
        
    }
    
}
