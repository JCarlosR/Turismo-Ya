//
//  MenuViewController.swift
//  Turismo Ya
//
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

class MenuViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,
    ShowPlacesDelegate, OpenMapDelegate {
    
    @IBOutlet weak var categoryTableView: UITableView!
    var categoryList = CategoryList()
    
    @IBOutlet weak var pickerViewCity: UIPickerView!
    

    @IBOutlet weak var menuItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        setTitle()
                
        categoryList.delegate = self
        loadCities()
        loadCategories()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuViewController.callbackUpdatedLanguage(notification:)), name: Notification.Name("updatedLanguage"), object: nil)
    }
    
    func callbackUpdatedLanguage(notification: Notification){
        loadCities()
        loadCategories()
        setTitle()
    }
    
    func setTitle() {
        self.navigationItem.title = Global.titleCategories
    }
    
    var selectedCategoryId: Int16 = 0
        
    func didSelectCategory(categoryId: Int16) {
        selectedCategoryId = categoryId
        performSegue(withIdentifier: "showPlacesSegue", sender: self)
    }
    
    func openMapView(categoryId: Int16) {
        // print("openMapView called")
        selectedCategoryId = categoryId
        performSegue(withIdentifier: "showMapSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlacesSegue" {
            if let destinationVC = segue.destination as? PlacesViewController {
                destinationVC.selectedCategoryId = self.selectedCategoryId
            }
        } else if segue.identifier == "showMapSegue" {
            if let destinationVC = segue.destination as? MyGoogleMapController {
                destinationVC.selectedCategoryId = self.selectedCategoryId
            }
        }
    }
    
    
    
    var cities: [City] = []
    
    func loadCities() {
        Alamofire.request("http://52.170.87.192:50/premiun/modules/aperturar.php?task=loadCiudad").responseJSON { response in
            
            print("Cities result:", response.result)
            
            if let result = response.result.value {
                let citiesData: NSArray = result as! NSArray
                for cityData: NSDictionary in citiesData as! [NSDictionary] {
                    let city = City()
                    city.id = Int16(cityData["idCiudad"]! as! String)!
                    city._name = cityData["Descripcion"]! as! String
                    city.latitude = Float(cityData["Latitud"]! as! String)!
                    city.longitude = Float(cityData["Altitud"]! as! String)!
                    self.cities.append(city)
                    self.pickerViewCity.reloadAllComponents()
                }
            }
        }
        
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
        return cities[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Ciudad seleccionada: \(cities[row].name)")
        requestCategoriesFor(cityId: cities[row].id)
        self.view.endEditing(true)
    }
    
    func loadCategories() {
        requestCategoriesFor(cityId: 1)
        
        categoryTableView.dataSource = categoryList
        categoryTableView.delegate = categoryList
        
        categoryTableView.rowHeight = UITableViewAutomaticDimension
        categoryTableView.estimatedRowHeight = 320
    }
    
    func requestCategoriesFor(cityId: Int16) {
        self.categoryList.clearCategories()
        
        Alamofire.request("http://52.170.87.192:50/premiun/modules/aperturar.php?task=loadLinea&idCiudad=\(cityId)").responseJSON { response in
            print("Categories result:", response.result)   // result of serialization
            
            if let result = response.result.value {
                let categoriesData: NSArray =  result as! NSArray
                for categoryData: NSDictionary in categoriesData as! [NSDictionary] {
                    let category = Category()
                    category.id = Int16(categoryData["idLinea"]! as! String)!
                    category._name = categoryData["Descripcion"]! as! String
                    category.imageUrl = categoryData["Imagen"]! as! String
                    self.categoryList.addCategory(category: category)
                    self.categoryTableView.reloadData()
                }
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
