//
//  PlacesViewController.swift
//  Turismo Ya
//
//  Created by rimenri on 03/03/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import Alamofire

class PlacesViewController: UIViewController,
    TypeSelectedDelegate, ScoreSelectedDelegate, ShowPlaceInfoDelegate {
    
    var pickerViewType: UIPickerView! = UIPickerView()
    var pickerViewScore: UIPickerView! = UIPickerView()
    
    @IBOutlet weak var tableViewPlaces: UITableView!
    
    @IBOutlet weak var txtType: UITextField!
    @IBOutlet weak var txtScore: UITextField!
        
    var placesList = PlacesList()
    var selectedCategoryId: Int16 = 0
    
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
    

    func loadTypesAndScores() {
        // Fetch types from WS
        let urlRequest = "http://52.170.87.192:50/premiun/modules/aperturar.php?task=loadSubLinea&idlinea=\(selectedCategoryId)"
        
        Alamofire.request(urlRequest).responseJSON { response in
            print("Sub categories result:", response.result)   // result of serialization
            
            if let result = response.result.value {
                let categoriesData: NSArray =  result as! NSArray
                for categoryData: NSDictionary in categoriesData as! [NSDictionary] {
                    let subCategory = SubCategory()
                    subCategory.id = Int16(categoryData["idSubLinea"]! as! String)!
                    subCategory._name = categoryData["Descripcion"]! as! String
                    subCategory.imageUrl = categoryData["Imagen"]! as! String
                    self.typePickerAdapter.addType(type: subCategory)
                    self.pickerViewType.reloadAllComponents()
                }
                
                self.txtType.text = self.typePickerAdapter.getFirstTypeText()
            }
        }
        
        /*typePickerAdapter.addType(typeName: "CARNES")
        typePickerAdapter.addType(typeName: "PESCADOS Y MARISCOS")
        typePickerAdapter.addType(typeName: "VEGETARIANA")
        typePickerAdapter.addType(typeName: "POLLOS A LA BRASA")
        */
        
        // Source & delegate for PickerView: Types
        pickerViewType.dataSource = typePickerAdapter
        pickerViewType.delegate = typePickerAdapter
        // Bind with the proper textField
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
        
        // Source & delegate for PickerView: Scores
        pickerViewScore.dataSource = scorePickerAdapter
        pickerViewScore.delegate = scorePickerAdapter
        // Bind with the proper textField
        txtScore.inputView = pickerViewScore
        
        // Delegates for new selections
        typePickerAdapter.delegate = self
        scorePickerAdapter.delegate = self
    }
    
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

    
    func loadPlaces() {
        // print("I have to load the places of the category \(selectedCategoryId)")
        Alamofire.request("http://52.170.87.192:50/premiun/modules/aperturar.php?task=loadProducto&idLinea=\(selectedCategoryId)").responseJSON { response in
            
            print("Places result:", response.result)   // result of response serialization
            
            if let result = response.result.value {
                let placesData: NSArray = result as! NSArray
                for placeData: NSDictionary in placesData as! [NSDictionary] {
                    let place = Place()
                    place.id = Int16(placeData["idProducto"]! as! String)!
                    place.idSubLinea = Int16(placeData["idSubLinea"]! as! String)!
                    place.abrev = placeData["Abrev"]! as! String
                    place.idValoracion = Int16(placeData["idValoracion"]! as! String)!
                    place._descripcion = placeData["Descripcion"]! as! String
                    place.telefono = placeData["Telefono"]! as! String
                    place.website = placeData["Website"]! as! String
                    place.address = placeData["Direccion"]! as! String
                    
                    place.horaAbre = placeData["HoraAbierto"]! as! String
                    place.horaCierra = placeData["HoraCierre"]! as! String
                    place.tenedor = placeData["Tenedor"]! as! String
                    
                    place.latitud = placeData["Latitud"]! as! String
                    place.longitud = placeData["Altitud"]! as! String
                    place.imageUrl = placeData["Imagen"]! as! String
                    
                    self.placesList.addPlace(place: place)
                    self.tableViewPlaces.reloadData()
                }
            }
        }
        
        tableViewPlaces.dataSource = placesList
        tableViewPlaces.delegate = placesList
                
        tableViewPlaces.rowHeight = UITableViewAutomaticDimension
        tableViewPlaces.estimatedRowHeight = 320
    }
    
    func reloadPlacesForSubCategory(subCategoryId: Int16) {
        placesList.applyFilter(subCategoryId: subCategoryId)
        self.tableViewPlaces.reloadData()
    }
    
    func reloadPlacesForScore(scoreId: Int16) {
        placesList.applyFilter(scoreId: scoreId)
        self.tableViewPlaces.reloadData()
    }
    
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
