//
//  TypePickerViewAdapter.swift
//  Turismo Ya
//
//  Created by rimenri on 03/03/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit

class TypePickerViewAdapter: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    weak var delegate: TypeSelectedDelegate?
    
    var types: [String] = ["CARNES", "PESCADOS Y MARISCOS", "VEGETARIANA", "POLLOS A LA BRASA", "COMIDA RÁPIDA"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // self.view.endEditing(true)
        return types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.newTypeWasSelected(typeName: types[row])
        print("Tipo seleccionado: \(types[row])")
    }
}


protocol TypeSelectedDelegate: class {
    func newTypeWasSelected(typeName: String)
}
