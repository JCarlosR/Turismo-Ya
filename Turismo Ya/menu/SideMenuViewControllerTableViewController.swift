//
//  SideMenuViewControllerTableViewController.swift
//  Turismo Ya
//
//  Created by rimenri on 02/05/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuViewControllerTableViewController: UITableViewController {

    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelLogout: UILabel!
    
    @IBAction func changeLangToEs(_ sender: Any) {
        Global.lang = "es"
        NotificationCenter.default.post(name: Notification.Name("updatedLanguage"), object: nil)
        self.dismiss(animated: true)
    }
        
    @IBAction func changeLangToEn(_ sender: Any) {
        Global.lang = "en"
        NotificationCenter.default.post(name: Notification.Name("updatedLanguage"), object: nil)
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        if let user = Global.user {
            labelUserName.text = user.name
        } else {
            labelUserName.text = Global.labelGuestUser
        }
        
        labelLogout.text = Global.labelLogout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch section
        {
        case 0:
            return Global.parseTextByLang(str: "Mis datos|My info")
        case 1:
            return Global.parseTextByLang(str: "Lenguaje|Language")
        case 2:
            return Global.parseTextByLang(str: "Contacto|Contact")
        default: // case 3
            return Global.parseTextByLang(str: "Salir|Exit")
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        if section == 0 {
            if Global.authenticated {
                return 2
            } else {
                return 1
            }
        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 2
        } else if section == 3 {
            return 1
        }
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
