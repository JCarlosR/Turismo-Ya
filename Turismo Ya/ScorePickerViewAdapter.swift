//
//  ScorePickerViewAdapter.swift
//  Turismo Ya
//
//  Created by rimenri on 03/03/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit

class ScorePickerViewAdapter: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var scores: [String] = ["5 PUNTOS", "4 PUNTOS O MÁS", "3 PUNTOS O MÁS", "2 PUNTOS O MÁS", "TODOS LOS LUGARES"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return scores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // self.view.endEditing(true)
        return scores[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Puntaje seleccionado: \(scores[row])")
    }
}
