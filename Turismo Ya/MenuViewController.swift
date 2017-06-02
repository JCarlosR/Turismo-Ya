//  MenuViewController.swift
//  Turismo Ya
//  Copyright © 2017 Programación y más. All rights reserved.

import UIKit
import SDWebImage
import Alamofire
import RealmSwift

class MenuViewController: UIViewController, ShowPlacesDelegate, OpenMapDelegate, CitySelectedDelegate,
        UISearchBarDelegate, ShowPlaceInfoDelegate {
    
    let searchBar: UISearchBar = UISearchBar()
    var isSearchActive: Bool = false
    var placesList = PlacesList()
    
    @IBOutlet weak var categoryTableView: UITableView!
    var categoryList = CategoryList()
    
    @IBOutlet weak var txtCity: UITextField!
    var cityPickerView: UIPickerView! = UIPickerView()
    var cityPickerViewAdapter = CityPickerViewAdapter()
    @IBOutlet weak var labelCity: UILabel!
    
    @IBOutlet weak var menuItem: UIBarButtonItem!
    
    
    // MARK: - Initial setup
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        setTitleAndLabel()
        setupSearchBar()
        
        categoryList.delegate = self
        loadRelationshipsAndCities()
        loadCategories()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuViewController.callbackUpdatedLanguage(notification:)), name: Notification.Name("updatedLanguage"), object: nil)
    }
    
    func callbackUpdatedLanguage(notification: Notification){
        loadCities()
        setTitleAndLabel()
    }
    
    func setTitleAndLabel() {
        self.navigationItem.title = Global.titleCategories
        self.labelCity.text = Global.labelCity
    }
    
    
    // MARK: - Search bar
    
    func setupSearchBar() {
        self.searchBar.delegate = self
        
        // click event over places
        self.placesList.delegate = self
    }
    
    var place: Place?
    func didSelectPlace(place: Place) {
        self.place = place
        performSegue(withIdentifier: "showPlaceSearchedSegue", sender: self)
    }
    
    @IBAction func itemSearchClicked(_ sender: Any) {
        if isSearchActive {
            self.navigationItem.titleView = nil
            self.categoryTableView.delegate = categoryList
            self.categoryTableView.dataSource = categoryList
            self.categoryTableView.reloadData()
        } else {
            self.navigationItem.titleView = searchBar
        }
        
        isSearchActive = !isSearchActive
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // print("Realm queries is pure magic")
        let realm = try! Realm()
        
        let query: String = self.searchBar.text ?? ""
        let places = realm.objects(Place.self).filter("abrev contains[c] %@", query)
        //
        self.placesList.filteredPlaces = Array(places)
        self.categoryTableView.delegate = placesList
        self.categoryTableView.dataSource = placesList
        self.categoryTableView.reloadData()
    }
    
    
    // MARK: - Category delegate
    
    var selectedCategoryId: Int16 = 0
    
    func didSelectCategory(categoryId: Int16) {
        selectedCategoryId = categoryId
        performSegue(withIdentifier: "showPlacesSegue", sender: self)
    }
    
    func openMapView(categoryId: Int16) {
        selectedCategoryId = categoryId
        performSegue(withIdentifier: "showMapSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlacesSegue" {
            if let destinationVC = segue.destination as? PlacesViewController {
                destinationVC.selectedCategoryId = self.selectedCategoryId
                destinationVC.selectedCityId = Global.selectedCityId
            }
        } else if segue.identifier == "showMapSegue" {
            if let destinationVC = segue.destination as? MapAndPlacesVController {
                destinationVC.selectedCategoryId = self.selectedCategoryId
            }
        } else if segue.identifier == "showPlaceSearchedSegue" {
            if let destinationVC = segue.destination as? PlaceInfoViewController {
                destinationVC.place = self.place
            }
        }
    }
    
    
    // MARK: - City and relations stuff
    
    func newCityWasSelected(cityName: String, cityId: Int16) {
        self.txtCity.text = cityName
        Global.selectedCityId = cityId
        requestCategoriesFor(cityId: cityId)
        
        // set the selected option and hide the picker view
        self.view.endEditing(false)
    }
    
    func loadRelationshipsAndCities() {
        // City PickerView
        cityPickerView.dataSource = cityPickerViewAdapter
        cityPickerView.delegate = cityPickerViewAdapter
        // Bind with the proper textField
        txtCity.inputView = cityPickerView
        // To propagate the selection event
        cityPickerViewAdapter.delegate = self
        
        if Connectivity.isConnectedToInternet() {
            Alamofire.request(Global.urlCityCategoryRelations).responseJSON { response in
                
                if let result = response.result.value {
                    
                    let arrayData: NSArray = result as! NSArray
                    let realm = try! Realm()
                    
                    try! realm.write {
                        let result = realm.objects(CiudadLinea.self)
                        realm.delete(result)
                    }
                    
                    for itemData: NSDictionary in arrayData as! [NSDictionary] {
                        let cityCategory = CiudadLinea()
                        cityCategory.idCiudad = itemData["idCiudad"]! as! String
                        cityCategory.idLinea = itemData["idLinea"]! as! String
                        try! realm.write {
                            realm.add(cityCategory)
                        }
                    }
                    
                    // AFTER LOAD RELATIONS
                    self.loadCities()
                }
            }
        } else {
            // DIRECTLY
            self.loadCities()
        }
    }
    
    func loadCities() {
        let realm = try! Realm()
        
        if !Connectivity.isConnectedToInternet() {
            // print("read City objects from realm")
            let cities = realm.objects(City.self)
            // convert from Results<City> to [City]
            self.cityPickerViewAdapter.cities = Array(cities)
            
            self.reloadCityPickerAndSetFirstOption()
            return
        }
        
        Alamofire.request(Global.urlCities).responseJSON { response in
            
            // print("Cities result:", response.result)
            if let result = response.result.value {
                let citiesData: NSArray = result as! NSArray
                for cityData: NSDictionary in citiesData as! [NSDictionary] {
                    let city = City()
                    city.id = Int16(cityData["idCiudad"]! as! String)!
                    city._name = cityData["Descripcion"]! as! String
                    city.latitude = Float(cityData["Latitud"]! as! String)!
                    city.longitude = Float(cityData["Altitud"]! as! String)!
                    self.cityPickerViewAdapter.add(city: city)
                }
                self.reloadCityPickerAndSetFirstOption()
                
                // Store in local storage using realm
                
                try! realm.write {
                    for city in self.cityPickerViewAdapter.cities {
                        realm.add(city, update: true)
                    }                    
                }
            }
        }
    }
    
    func reloadCityPickerAndSetFirstOption() {
        self.cityPickerView.reloadAllComponents()
        
        // show the first option (city)
        if self.cityPickerViewAdapter.cities.count > 0 {
            let firstCity: City = self.cityPickerViewAdapter.getFirstOption()
            self.txtCity.text = firstCity.name
            self.requestCategoriesFor(cityId: firstCity.id)
        }
    }
    
    
    // MARK: - Categories
    
    func loadCategories() {
        // the categories are loaded once
        // they will be read from realm and filtered using requestCategoriesFor(cityId: i)
        
        
        categoryTableView.dataSource = categoryList
        categoryTableView.delegate = categoryList
        
        categoryTableView.rowHeight = UITableViewAutomaticDimension
        categoryTableView.estimatedRowHeight = 320
    
        
        let realm = try! Realm()
        
        Alamofire.request(Global.urlCategories).responseJSON { response in
            // print("Categories result:", response.result)
            
            if let result = response.result.value {
                let categoriesData: NSArray =  result as! NSArray
                for categoryData: NSDictionary in categoriesData as! [NSDictionary] {
                    let category = Category()
                    category.id = Int16(categoryData["idLinea"]! as! String)!
                    category._name = categoryData["Descripcion"]! as! String
                    category.imageUrl = categoryData["Imagen"]! as! String
                    
                    try! realm.write {
                        realm.add(category, update: true)
                    }
                }
                
            }
        }
    }
    
    func requestCategoriesFor(cityId: Int16) {
        self.categoryList.clearCategories()
        
        let realm = try! Realm()        
        
        let categoryCityRelationships = realm.objects(CiudadLinea.self).filter("idCiudad == '\(cityId)'")
        let categories = realm.objects(Category.self)
        
        var filteredCategories: [Category] = []
            
        for category in categories {
            for categoryCity in categoryCityRelationships {
                if category.id == Int16(categoryCity.idLinea) {
                    filteredCategories.append(category)
                    break
                }
            }
        }
        self.categoryList.categories = filteredCategories
        self.categoryTableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
