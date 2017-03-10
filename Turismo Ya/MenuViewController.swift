//
//  MenuViewController.swift
//  Turismo Ya
//
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import SDWebImage

class MenuViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,
    ShowPlacesDelegate, OpenMapDelegate {
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    var categoryList = CategoryList()
    
    @IBOutlet weak var pickerViewCity: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryList.delegate = self
        
        loadCities()
        
        loadCategories()
    }
        
    func didSelectCategory(categoryName: String) {
        performSegue(withIdentifier: "showPlacesSegue", sender: self)
    }
    
    func openMapView() {
        print("openMapView called")
        performSegue(withIdentifier: "showMapSegue", sender: self)
    }
    
    
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
        self.view.endEditing(true)
    }
    
    func loadCategories() {
        
        categoryList.addCategory(categoryName: "DÓNDE COMER", categoryImageUrl: "https://agendamariajulia.files.wordpress.com/2017/02/2paco_1433153168_a.jpg?w=256&h=256&crop=1")
        categoryList.addCategory(categoryName: "OCIO", categoryImageUrl: "https://i0.wp.com/hurtadointermedia.com/wp-content/uploads/2016/11/birthday-party.jpg")
        categoryList.addCategory(categoryName: "HOSPEDAJE", categoryImageUrl: "https://pbs.twimg.com/profile_images/3307514251/c499a6d5d7c6e3e52d87248f0dfec7bf.jpeg")
        categoryList.addCategory(categoryName: "BARES", categoryImageUrl: "https://www.coventgarden.london/sites/default/files/styles/cg_place_detail_1_1/public/cg_images/Lima-Floral-Bajo-Bar-Covent-Garden-2.jpg")
        categoryList.addCategory(categoryName: "COMPRAS", categoryImageUrl: "http://coliseo-intl.com/wp-content/uploads/2015/03/compras1.jpg")
        // categoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        categoryTableView.dataSource = categoryList
        categoryTableView.delegate = categoryList
        // categoryTableView.reloadData()
        
        
        categoryTableView.rowHeight = UITableViewAutomaticDimension
        categoryTableView.estimatedRowHeight = 320
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
