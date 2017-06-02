//
//  RegisterViewController.swift
//  Turismo Ya
//
//  Created by rimenri on 09/03/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController, CountrySelectedDelegate, UIPickerViewDelegate {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    
    var countryPickerViewAdapter = CountryPickerViewAdapter()
    var countryPickerView: UIPickerView! = UIPickerView()
    var selectedCountryId: String = ""
    
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // add border to buttons
        // btn.backgroundColor = .clear
        btnRegister.layer.cornerRadius = 17
        btnRegister.layer.borderWidth = 1
        btnRegister.layer.borderColor = UIColor.black.cgColor
        
        //
        btnFacebook.layer.cornerRadius = 17
        btnFacebook.layer.borderWidth = 1
        btnFacebook.layer.borderColor = UIColor.black.cgColor
        
        loadCountries()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newCountryWasSelected(countryName: String, countryId: String)
    {
        self.txtCountry.text = countryName
        self.selectedCountryId = countryId
        
        // set the selected option and hide the picker view
        self.view.endEditing(false)
    }
    
    func loadCountries()
    {
        let urlRequest = Global.urlContries
        
        Alamofire.request(urlRequest).responseJSON { response in
            print("Countries result:", response.result) // result
            
            if let result = response.result.value {
                let arrayData: NSArray =  result as! NSArray
                for countryData: NSDictionary in arrayData as! [NSDictionary] {
                    let country = Country()
                    country.idPais = countryData["idPais"]! as! String
                    country._descripcion = countryData["Descripcion"]! as! String
                    self.countryPickerViewAdapter.add(country: country)
                    self.countryPickerView.reloadAllComponents()
                }
                
                let firstCountry: Country = self.countryPickerViewAdapter.getFirstOption()
                self.txtCountry.text = firstCountry.descripcion
                self.selectedCountryId = firstCountry.idPais
            }
        }
        
        // Source & delegate for PickerView
        countryPickerView.dataSource = countryPickerViewAdapter
        countryPickerView.delegate = countryPickerViewAdapter
        // Bind with the proper textField
        txtCountry.inputView = countryPickerView
        // To propagate the selection event
        countryPickerViewAdapter.delegate = self
    }
    
    @IBAction func btnConfirmRegisterPressed(_ sender: UIButton) {
        let email: String! = txtEmail.text
        let name: String! = txtName.text
        let lastName: String! = txtLastName.text
        
        if email.characters.count < 3 || name.characters.count < 3 {
            Global.showToast(message: "Ingrese sus datos", viewController: self)
            return
        }
        
        var params: String = "&nombre=\(name!)&apellido=\(lastName!)&idpais=\(selectedCountryId)&email=\(email!)"
        
        params = params.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        
        Alamofire.request(Global.urlRegister + params)
            .responseJSON { response in
            // print("Register result:", response.result)
            debugPrint(response)
            if let result = response.result.value {
                let responseCode: Int16 =  result as! Int16
                print("Response code for register: \(responseCode)")
                /*var message = ""
                if responseCode == 2 {
                    message = "Usuario ya existente"
                } else if responseCode == 1 {
                    message = "Registro satisfactorio"
                }*/
                
                // Global.showToast(message: message, viewController: self)
                if responseCode == 1 || responseCode == 2 {
                    Global.setAuthenticatedUser(name: name, email: email)
                    self.performSegue(withIdentifier: "registerToMenuSegue", sender: self)
                } else {
                    Global.showToast(message: "Rpta del servidor desconocida", viewController: self)
                }
                
            }
        }
    }

    @IBAction func btnBackPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        // _ = navigationController?.popViewController(animated: true)
    }
    
    
    /*
    // MARK: - Navigation
r5 dsa
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
            debugPrint(self)
        #endif
        return self
    }
}
