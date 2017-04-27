//
//  ScorePickerViewAdapter.swift
//  Turismo Ya
//
//  Created by rimenri on 03/03/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit

class ScorePickerViewAdapter: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    weak var delegate: ScoreSelectedDelegate?
    
    var scores: [Score] = []
    
    func setScoreOptions(scoreOptions: [Score]) {
        scores = scoreOptions
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return scores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return scores[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.newScoreWasSelected(scoreId: scores[row].id, scoreName: scores[row].name)
        // print("Puntaje seleccionado: \(scores[row])")
    }
}

protocol ScoreSelectedDelegate: class {
    func newScoreWasSelected(scoreId: Int16, scoreName: String)
}
