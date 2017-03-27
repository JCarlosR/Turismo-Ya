//
//  PlacesViewController.swift
//  Turismo Ya
//
//  Created by rimenri on 03/03/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit

class PlacesViewController: UIViewController,
    TypeSelectedDelegate, ScoreSelectedDelegate {
    
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
        
        // places.delegate = self
        
        loadTypesAndScores()
        
        loadPlaces()
    }
    

    func loadTypesAndScores() {
        // Data source and delegate for types
        pickerViewType.dataSource = typePickerAdapter
        pickerViewType.delegate = typePickerAdapter
        // Bind with the proper textField
        txtType.inputView = pickerViewType
        
        // Data source and delegate for scores
        pickerViewScore.dataSource = scorePickerAdapter
        pickerViewScore.delegate = scorePickerAdapter
        // Bind with the proper textField
        txtScore.inputView = pickerViewScore
        
        // Delegates for new selections
        typePickerAdapter.delegate = self
        scorePickerAdapter.delegate = self
    }
    
    func newTypeWasSelected(typeName: String) {
        txtType.text = typeName
        self.view.endEditing(false)
    }
    
    func newScoreWasSelected(scoreName: String) {
        txtScore.text = scoreName
        self.view.endEditing(false)
    }

    
    func loadPlaces() {
        print("I have to load the places of the category \(selectedCategoryId)")
        placesList.addPlace(placeName: "Casa Andina")
        placesList.addPlace(placeName: "El Sombrero")
        placesList.addPlace(placeName: "El Mochica")
        placesList.addPlace(placeName: "Rincón de Vallejo")
        
        tableViewPlaces.dataSource = placesList
        tableViewPlaces.delegate = placesList
        // categoryTableView.reloadData()
        
        tableViewPlaces.rowHeight = UITableViewAutomaticDimension
        tableViewPlaces.estimatedRowHeight = 320
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
