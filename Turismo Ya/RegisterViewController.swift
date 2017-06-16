import UIKit
import Alamofire
import  FacebookCore
import FacebookLogin

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
        //
        btnFacebook.addTarget(self, action: #selector(loginButtonClicked), for: UIControlEvents.touchUpInside)

        
        loadCountries()
    }
    
    // Once the button is clicked, show the login dialog
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.loginBehavior = LoginBehavior.native;
        loginManager.logIn([ .publicProfile, .email ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, _, _):
                if grantedPermissions.contains("email")
                {
                    self.startLoginWithFacebookData()
                } else {
                    Global.showToast(message: "Permiso de FB denegado", viewController: self)
                }
            }
        }
    }
    
    struct MyProfileRequest: GraphRequestProtocol {
        struct Response: GraphResponseProtocol {
            let rawResponse: Any?
            init(rawResponse: Any?) {
                // Decode JSON from rawResponse into other properties here.
                self.rawResponse = rawResponse
            }
            
            public var dictionaryValue: [String : Any]? {
                return rawResponse as? [String : Any]
            }
        }
        
        var graphPath = "/me"
        var parameters: [String : Any]? = ["fields": "id, name, first_name, last_name, email"]
        var accessToken = AccessToken.current
        var httpMethod: GraphRequestHTTPMethod = .GET
        var apiVersion: GraphAPIVersion = .defaultVersion
    }
    
    func startLoginWithFacebookData() {
        if AccessToken.current != nil {
            
            
            let connection = GraphRequestConnection()
            connection.add(MyProfileRequest()) { response, result in
                switch result {
                case .success(let response):
                    if let responseDictionary = response.dictionaryValue {
                        print(responseDictionary)
                        
                        let name: String = responseDictionary["first_name"] as! String
                        let lastName: String = responseDictionary["last_name"] as! String
                        let email: String = responseDictionary["email"] as! String
                        self.performRegisterRequest(name: name, lastName: lastName, email: email)
                    }
                    
                case .failed(let error):
                    print("Custom Graph Request Failed: \(error)")
                }
            }
            connection.start()
        }
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
        
        self.performRegisterRequest(name: name, lastName: lastName, email: email)
    }
        
    func performRegisterRequest(name: String, lastName: String, email: String) {
        var params: String = "&nombre=\(name)&apellido=\(lastName)&idpais=\(selectedCountryId)&email=\(email)"
        
        params = params.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        
        Alamofire.request(Global.urlRegister + params)
            .responseJSON { response in
                // print("Register result:", response.result)
                // debugPrint(response)
                if let result = response.result.value {
                    let responseCode: Int16 =  result as! Int16
                    // print("Response code for register: \(responseCode)")
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
