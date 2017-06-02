//  TouristGuideTableViewController.swift

import UIKit
import Alamofire
import RealmSwift

class TouristGuideViewController: UIViewController, LanguageSelectedDelegate {
    
    @IBOutlet weak var labelLanguage: UILabel!
    @IBOutlet weak var labelLinkDownloadList: UIButton!
    
    @IBOutlet weak var txtLanguage: UITextField!
    var languagePickerViewAdapter = LanguagePickerViewAdapter()
    var languagePickerView: UIPickerView! = UIPickerView()
    var idSelectedLanguage: String = ""
    
    
    @IBOutlet weak var tableViewTouristGuide: UITableView!
    var touristGuideList = TouristGuideList()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLabels()
        
        loadLanguages()
        setupTouristGuide()
    }
    
    func setupLabels() {
        self.labelLanguage.text = Global.labelLanguage
        self.labelLinkDownloadList.setTitle(Global.labelLinkDownloadList, for: .normal)
    }
    
    @IBAction func linkDownloadListPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "http://www.regionlalibertad.gob.pe/exportaturis/index.php?option=com_docman&task=doc_download&gid=31&Itemid=62")!)
    }
    
    func newLanguageWasSelected(languageName: String, languageId: String) {
        // set the selected option
        self.txtLanguage.text = languageName
        self.idSelectedLanguage = languageId
        self.reloadTouristGuide()
        
        // and hide the picker view
        self.view.endEditing(false)
    }
    
    func loadLanguages() {
        // PickerView setup
        languagePickerView.dataSource = languagePickerViewAdapter
        languagePickerView.delegate = languagePickerViewAdapter
        // Bind with the textField
        txtLanguage.inputView = languagePickerView
        // To handle the selection event
        languagePickerViewAdapter.delegate = self
        
        
        let realm = try! Realm()
        
        if Connectivity.isConnectedToInternet() {
            let urlRequest = Global.urlLanguages
            
            Alamofire.request(urlRequest).responseJSON { response in
                // print("Languages result:", response.result)
                
                if let result = response.result.value {
                    let arrayData: NSArray =  result as! NSArray
                    for itemData: NSDictionary in arrayData as! [NSDictionary] {
                        let language = Language()
                        language.idIdiomaGuia = itemData["idIdiomaGuia"]! as! String
                        language._descripcion = itemData["Descripcion"]! as! String
                        self.languagePickerViewAdapter.add(language: language)
                    }
                    self.languagePickerView.reloadAllComponents()
                    
                    let firstLanguage: Language = self.languagePickerViewAdapter.getFirstOption()
                    self.txtLanguage.text = firstLanguage.descripcion
                    self.idSelectedLanguage = firstLanguage.idIdiomaGuia
                    
                    self.reloadTouristGuide()
                    
                    
                    // persist data
                    try! realm.write {
                        for language in self.languagePickerViewAdapter.languages {
                            realm.add(language, update: true)
                        }
                    }
                }
            }
        } else {
            print("read Language objects from realm")
            let languages = realm.objects(Language.self)
            // convert from Results<Language> to [Language]
            self.languagePickerViewAdapter.languages = Array(languages)
            
            self.languagePickerView.reloadAllComponents()
            
            let firstLanguage: Language = self.languagePickerViewAdapter.getFirstOption()
            self.txtLanguage.text = firstLanguage.descripcion
            self.idSelectedLanguage = firstLanguage.idIdiomaGuia
            
            self.reloadTouristGuide()
            return
        }
        
        
    }
    
    func setupTouristGuide() {
        // it is loaded after load languages (based on the first language option)
        
        tableViewTouristGuide.dataSource = touristGuideList
        tableViewTouristGuide.delegate = touristGuideList
        
        tableViewTouristGuide.rowHeight = UITableViewAutomaticDimension
        // tableViewTouristGuide.estimatedRowHeight = 320
    }
    
    func reloadTouristGuide() {
        // Load the tourist guide just once
        if self.touristGuideList.guides.count > 0 {
            self.touristGuideList.applyFilter(idIdioma: self.idSelectedLanguage)
            self.tableViewTouristGuide.reloadData()
            return
        }
        
        
        let realm = try! Realm()
        
        // Load the full tourist guide the first time
        if Connectivity.isConnectedToInternet() {
            Alamofire.request(Global.urlTouristGuide).responseJSON { response in
                // print("Tourist guide result:", response.result)
                
                if let result = response.result.value {
                    let arrayData: NSArray =  result as! NSArray
                    for itemData: NSDictionary in arrayData as! [NSDictionary] {
                        let guide = Guide()
                        guide.idGuia = itemData["idGuia"]! as! String
                        guide.nombre = itemData["Nombre"]! as! String
                        guide.sexo = itemData["Sexo"]! as! String
                        guide.ruc = itemData["Ruc"]! as! String
                        guide.dni = itemData["Dni"]! as! String
                        guide.idioma = itemData["Idioma"]! as! String
                        guide.telefono = itemData["Telefono"]! as! String
                        guide.email = itemData["Email"]! as! String
                        //  guide.fechaExpedicion = itemData["FechaExpedicion"]! as! String
                        self.touristGuideList.addGuide(guide: guide)
                    }
                    
                    self.touristGuideList.applyFilter(idIdioma: self.idSelectedLanguage)
                    self.tableViewTouristGuide.reloadData()
                    
                    // persist data
                    try! realm.write {
                        for guide in self.touristGuideList.guides {
                            realm.add(guide, update: true)
                        }
                    }
                }
            }
        } else {
            print("read Guide objects from realm")
            let guides = realm.objects(Guide.self)
            // convert from Results<Guide> to [Guide]
            self.touristGuideList.guides = Array(guides)
            
            self.touristGuideList.applyFilter(idIdioma: self.idSelectedLanguage)
            self.tableViewTouristGuide.reloadData()
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
