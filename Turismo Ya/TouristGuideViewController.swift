//
//  TouristGuideTableViewController.swift
//  Turismo Ya
//
//  Created by rimenri on 10/05/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import Alamofire

class TouristGuideViewController: UIViewController, LanguageSelectedDelegate {
    
    
    @IBOutlet weak var labelLanguage: UILabel!
    
    @IBOutlet weak var txtLanguage: UITextField!
    var languagePickerViewAdapter = LanguagePickerViewAdapter()
    var languagePickerView: UIPickerView! = UIPickerView()
    var idSelectedLanguage: String = ""
    
    
    @IBOutlet weak var tableViewTouristGuide: UITableView!
    var touristGuideList = TouristGuideList()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadLanguages()
        setupTouristGuide()
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
                    self.languagePickerView.reloadAllComponents()
                }
                
                let firstLanguage: Language = self.languagePickerViewAdapter.getFirstOption()
                self.txtLanguage.text = firstLanguage.descripcion
                
                self.idSelectedLanguage = firstLanguage.idIdiomaGuia
                self.reloadTouristGuide()
            }
        }
        
        // Source & delegate for PickerView
        languagePickerView.dataSource = languagePickerViewAdapter
        languagePickerView.delegate = languagePickerViewAdapter
        // Bind with the proper textField
        txtLanguage.inputView = languagePickerView
        // To propagate the selection event
        languagePickerViewAdapter.delegate = self
    }
    
    func setupTouristGuide() {
        // it is loaded after load languages (based on the first language option)
        
        tableViewTouristGuide.dataSource = touristGuideList
        tableViewTouristGuide.delegate = touristGuideList
        
        tableViewTouristGuide.rowHeight = UITableViewAutomaticDimension
        // tableViewTouristGuide.estimatedRowHeight = 320
    }
    
    func reloadTouristGuide() {
        // self.touristGuideList.clearGuides()
        if self.touristGuideList.guides.count > 0 {
            self.touristGuideList.applyFilter(idIdioma: self.idSelectedLanguage)
            self.tableViewTouristGuide.reloadData()
            return
        }
        
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
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
