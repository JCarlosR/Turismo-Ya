//
//  LanguagePickerViewAdapter.swift
//  Turismo Ya
//

import UIKit

class LanguagePickerViewAdapter: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    weak var delegate: LanguageSelectedDelegate?
    
    var languages: [Language] = []
    
    func add(language: Language) {
        languages.append(language)
    }
    
    func getFirstOption() -> Language {
        return languages[0]
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row].descripcion
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.newLanguageWasSelected(languageName: languages[row].descripcion, languageId: languages[row].idIdiomaGuia)
    }
    
}


protocol LanguageSelectedDelegate: class {
    func newLanguageWasSelected(languageName: String, languageId: String)
}

