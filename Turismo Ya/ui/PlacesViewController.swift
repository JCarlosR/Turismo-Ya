//
//  PlacesViewController.swift
//  Turismo Ya
//
//  Created by rimenri on 03/03/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit

class PlacesViewController: UIViewController {
    

    @IBOutlet weak var pickerViewType: UIPickerView!
    @IBOutlet weak var pickerViewScore: UIPickerView!
    @IBOutlet weak var tableViewPlaces: UITableView!
    
    var placesList = PlacesList()
    
    var typePickerAdapter = TypePickerViewAdapter()
    var scorePickerAdapter = ScorePickerViewAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // places.delegate = self
        
        loadTypesAndScores()
        
        loadPlaces()
    }
    

    func loadTypesAndScores() {
        pickerViewType.dataSource = typePickerAdapter
        pickerViewType.delegate = typePickerAdapter
        
        pickerViewScore.dataSource = scorePickerAdapter
        pickerViewScore.delegate = scorePickerAdapter
    }
    

    
    func loadPlaces() {
        placesList.addPlace(placeName: "Casa Andina")
        placesList.addPlace(placeName: "El Sombrero")
        placesList.addPlace(placeName: "El Mochica")
        placesList.addPlace(placeName: "Rincón de Vallejo")
        
        tableViewPlaces.dataSource = placesList
        tableViewPlaces.delegate = placesList
        // categoryTableView.reloadData()
        
        tableViewPlaces.rowHeight = UITableViewAutomaticDimension
        // tableViewPlaces.estimatedRowHeight = 320
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
