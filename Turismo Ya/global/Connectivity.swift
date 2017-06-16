//  Connectivity.swift

import UIKit
import Alamofire

class Connectivity: NSObject {
    static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
