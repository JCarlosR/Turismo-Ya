//
//  CityPickerViewAdapter.swift
//  Turismo Ya
//
//  Created by rimenri on 05/05/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit

class CityPickerViewAdapter: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    weak var delegate: CitySelectedDelegate?
    
    var cities: [City] = []
    
    func add(city: City) {
        cities.append(city)
    }
    
    func getFirstOption() -> City {
        return cities[0]
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.newCityWasSelected(cityName: cities[row].name, cityId: cities[row].id)
    }
    
}


protocol CitySelectedDelegate: class {
    func newCityWasSelected(cityName: String, cityId: Int16)
}
