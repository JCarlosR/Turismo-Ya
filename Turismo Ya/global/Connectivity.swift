//
//  Connectivity.swift
//  Turismo Ya
//
//  Created by rimenri on 18/05/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import Alamofire

class Connectivity: NSObject {
    static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
