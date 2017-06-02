//  PlacesViewController.swift
//  Copyright © 2017 Programación y más. All rights reserved.

import UIKit
import Alamofire
import RealmSwift

class PlacesViewController: UIViewController,
    TypeSelectedDelegate, ScoreSelectedDelegate, ShowPlaceInfoDelegate {
    
    // 2 Picker View
    var pickerViewType: UIPickerView! = UIPickerView()
    var pickerViewScore: UIPickerView! = UIPickerView()
    
    // Table view
    @IBOutlet weak var tableViewPlaces: UITableView!
    
    // 2 Text Field (bound to the picker views)
    @IBOutlet weak var txtType: UITextField!
    @IBOutlet weak var txtScore: UITextField!
    
    // Places
    var placesList = PlacesList()
    var selectedCategoryId: Int16 = 0
    var selectedCityId: Int16 = 0
    
    // 2 Adapters (picker views)
    var typePickerAdapter = TypePickerViewAdapter()
    var scorePickerAdapter = ScorePickerViewAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Global.titlePlaces
        
        // listen for place selection
        placesList.delegate = self
        
        // load data
        loadTypesAndScores()
        loadPlaces()
    }
    

    // MARK: - Load picker views
    
    func loadTypesAndScores() {
        // Fetch types from WS
        
        if Connectivity.isConnectedToInternet() {
            let urlRequest = Global.urlTypes + "&idlinea=\(selectedCategoryId)"
            
            Alamofire.request(urlRequest).responseJSON { response in
                // print("Sub categories result:", response.result)
                
                if let result = response.result.value {
                    let categoriesData: NSArray =  result as! NSArray
                    for categoryData: NSDictionary in categoriesData as! [NSDictionary] {
                        let subCategory = SubCategory()
                        subCategory.id = Int16(categoryData["idSubLinea"]! as! String)!
                        subCategory.idLinea = categoryData["idLinea"]! as! String
                        subCategory._name = categoryData["Descripcion"]! as! String
                        subCategory.imageUrl = categoryData["Imagen"]! as! String
                        self.typePickerAdapter.addType(type: subCategory)
                    }
                    
                    self.pickerViewType.reloadAllComponents()
                    self.txtType.text = self.typePickerAdapter.getFirstTypeText()
                    
                    // persist data
                    let realm = try! Realm()
                    try! realm.write {
                        for type in self.typePickerAdapter.types {
                            realm.add(type, update: true)
                        }
                    }
                }
            }
        } else {
            let realm = try! Realm()
            print("read SubCategory objects from realm")
            
            let types = realm.objects(SubCategory.self).filter("idLinea == '\(selectedCategoryId)'")
            if types.count > 0 {
                self.typePickerAdapter.types = Array(types)
                self.pickerViewType.reloadAllComponents()
                self.txtType.text = self.typePickerAdapter.getFirstTypeText()
            }
        }
        
        
        // Type == SubCategory
        // Examples: "CARNES", "PESCADOS Y MARISCOS"
        
        // Setup PickerView: Types
        pickerViewType.dataSource = typePickerAdapter
        pickerViewType.delegate = typePickerAdapter
        txtType.inputView = pickerViewType
        
        // Score options
        var scoreOptions: [Score] = []
        scoreOptions.append(Score(id: 0, _name: "Todos los lugares|All places"))
        scoreOptions.append(Score(id: 5, _name: "5 puntos|5 points"))
        scoreOptions.append(Score(id: 4, _name: "4 puntos|4 points"))
        scoreOptions.append(Score(id: 3, _name: "3 puntos|3 points"))
        scoreOptions.append(Score(id: 2, _name: "2 puntos|2 points"))
        scoreOptions.append(Score(id: 1, _name: "1 punto|1 point"))
        txtScore.text = scoreOptions[0].name
        scorePickerAdapter.setScoreOptions(
            scoreOptions: scoreOptions
        )
        
        // Setup PickerView: Scores
        pickerViewScore.dataSource = scorePickerAdapter
        pickerViewScore.delegate = scorePickerAdapter
        // Bind with textField
        txtScore.inputView = pickerViewScore
        
        // Delegates for new selections
        typePickerAdapter.delegate = self
        scorePickerAdapter.delegate = self
    }
    
    
    // MARK: - Filters have changed
    
    func newTypeWasSelected(typeName: String, typeId: Int16) {
        txtType.text = typeName
        self.view.endEditing(false)
        reloadPlacesForSubCategory(subCategoryId: typeId)
    }
    
    func newScoreWasSelected(scoreId: Int16, scoreName: String) {
        txtScore.text = scoreName
        self.view.endEditing(false)
    
        reloadPlacesForScore(scoreId: scoreId)
    }

    
    // MARK: - Load places
    
    func loadPlaces() {
        let realm = try! Realm()
        
        // TableView Places setup
        tableViewPlaces.dataSource = placesList
        tableViewPlaces.delegate = placesList
        tableViewPlaces.rowHeight = UITableViewAutomaticDimension
        tableViewPlaces.estimatedRowHeight = 320
        
        // read locally
        let places = realm.objects(Place.self).filter("idLinea = '\(selectedCategoryId)'")
        self.feedPlacesListAndReloadTable(placesByCategory: Array(places))
        
        if Connectivity.isConnectedToInternet() {
            // print("load the places of the category \(selectedCategoryId)")
            Alamofire.request(Global.urlPlaces + "&idLinea=\(selectedCategoryId)").responseJSON { response in
                
                // print("Places result:", response.result)
                if let result = response.result.value {
                    let placesData: NSArray = result as! NSArray
                    var placesByCategory: [Place] = []
                    
                    for placeData: NSDictionary in placesData as! [NSDictionary] {
                        let place = Place()
                        place.id = Int16(placeData["idProducto"]! as! String)!
                        place.idSubLinea = Int16(placeData["idSubLinea"]! as! String)!
                        place.idLinea = placeData["idLinea"]! as! String
                        place.abrev = placeData["Abrev"]! as! String
                        place.idValoracion = Int16(placeData["idValoracion"]! as! String)!
                        place._descripcion = placeData["Descripcion"]! as! String
                        place.telefono = placeData["Telefono"] as? String ?? ""
                        place.website = placeData["Website"] as? String ?? ""
                        place.address = placeData["Direccion"] as? String ?? ""
                        
                        place.horaAbre = placeData["HoraAbierto"]! as! String
                        place.horaCierra = placeData["HoraCierre"]! as! String
                        place.tenedor = placeData["Tenedor"] as? String ?? ""
                        
                        place.latitud = placeData["Latitud"]! as! String
                        place.longitud = placeData["Altitud"]! as! String
                        place.imageUrl = placeData["Imagen"]! as! String
                        
                        place.idCiudad = placeData["idCiudad"]! as! String
                        place.ruc = placeData["ruc"]! as! String
                        
                        placesByCategory.append(place)
                    }
                    self.feedPlacesListAndReloadTable(placesByCategory: placesByCategory)
                    
                    // persist data
                    let realm = try! Realm()
                    try! realm.write {
                        for place in self.placesList.places {
                            realm.add(place, update: true)
                        }
                    }
                }
            }
        }
        
    }
    
    func feedPlacesListAndReloadTable(placesByCategory: [Place]) {
        print("filtering \(placesByCategory.count) places by city id: \(selectedCityId)")
        for possiblePlace in placesByCategory {
            // hardcoded all city
            if selectedCityId==1 || possiblePlace.idCiudad == String(selectedCityId) {
                self.placesList.addPlace(place: possiblePlace)
            }
        }
        self.tableViewPlaces.reloadData()
    }
    
    // MARK: - Apply filters
    
    func reloadPlacesForSubCategory(subCategoryId: Int16) {
        placesList.applyFilter(subCategoryId: subCategoryId)
        self.tableViewPlaces.reloadData()
    }
    
    func reloadPlacesForScore(scoreId: Int16) {
        placesList.applyFilter(scoreId: scoreId)
        self.tableViewPlaces.reloadData()
    }
    
    
    // MARK: - Clic event and segue
    
    var place: Place?
    func didSelectPlace(place: Place) {
        self.place = place
        performSegue(withIdentifier: "showPlaceInfoSegue", sender: self)
    }
    
    // pass parameters via segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlaceInfoSegue" {
            if let destinationVC = segue.destination as? PlaceInfoViewController {
                destinationVC.place = self.place
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
