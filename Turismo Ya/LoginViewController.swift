//
//  LoginViewController.swift
//  Turismo Ya
//
//  Created by rimenri on 10/03/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnEnterPressed(_ sender: UIButton) {
        let email: String = txtEmail.text!
        
        if email.characters.count < 3 {
            Global.showToast(message: "Ingresa un email válido", viewController: self)
            return
        }
        
        var params: String = "&email=\(email)"
        params = params.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        
        Alamofire.request(Global.urlLogin + params)
            .responseJSON { response in
                // print("Register result:", response.result)
                // debugPrint(response)
                if let result = response.result.value {
                    let arrayData: NSArray = result as! NSArray
                    for naveganteData: NSDictionary in arrayData as! [NSDictionary] {
                        let user = User()
                        user.id = naveganteData["idNavegante"]! as! String
                        user.name = naveganteData["Nombre"]! as! String
                        user.countryId = naveganteData["idPais"]! as! String
                        user.email = naveganteData["Email"]! as! String
                        
                        Global.setAuthenticatedUser(user: user)
                        self.performSegue(withIdentifier: "loginToMenuSegue", sender: self)
                    }
                }
        }
    }
    @IBAction func btnBackPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
