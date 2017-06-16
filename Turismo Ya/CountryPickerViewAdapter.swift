//
//  CountryList.swift
//  Turismo Ya
//
//

import UIKit

class CountryPickerViewAdapter: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    weak var delegate: CountrySelectedDelegate?
    
    var countries: [Country] = []
    
    func add(country: Country) {
        countries.append(country)
    }
    
    func getFirstOption() -> Country {
        return countries[0]
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row].descripcion
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.newCountryWasSelected(countryName: countries[row].descripcion, countryId: countries[row].idPais)
    }
    
}


protocol CountrySelectedDelegate: class {
    func newCountryWasSelected(countryName: String, countryId: String)
}

