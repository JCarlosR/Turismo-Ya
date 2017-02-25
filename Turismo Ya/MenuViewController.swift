//
//  MenuViewController.swift
//  Turismo Ya
//
//  Created by rimenri on 22/02/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var categoryTableView: UITableView!
    
    var categoryList = CategoryList()
    
    @IBOutlet weak var pickerViewCity: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // categoryList.delegate = self
        
        loadCities()
        
        loadCategories()
    }
    
    /*func didSelectCategory(categoryName: String) {
        performSegue(withIdentifier: "showPlacesSegue", sender: self)
    }*/
    
    var cities: [String] = ["Todos", "Pacasmayo", "Trujillo", "Chimbote"]
    
    func loadCities() {
        pickerViewCity.dataSource = self
        pickerViewCity.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Ciudad seleccionada: \(cities[row])")
    }
    
    func loadCategories() {
        categoryList.addCategory(categoryName: "DÓNDE COMER")
        categoryList.addCategory(categoryName: "OCIO")
        categoryList.addCategory(categoryName: "HOSPEDAJE")
        categoryList.addCategory(categoryName: "BARES")
        categoryList.addCategory(categoryName: "COMPRAS")
        // categoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        categoryTableView.dataSource = categoryList
        categoryTableView.delegate = categoryList
        // categoryTableView.reloadData()
    
        categoryTableView.rowHeight = UITableViewAutomaticDimension
        categoryTableView.estimatedRowHeight = 500
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
