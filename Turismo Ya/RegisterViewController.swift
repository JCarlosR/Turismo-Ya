//
//  RegisterViewController.swift
//  Turismo Ya
//
//  Created by rimenri on 09/03/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var labelAccept: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        labelAccept.numberOfLines = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnBackPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        // _ = navigationController?.popViewController(animated: true)
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
