//
//  WelcomeMessageViewController.swift

import UIKit
import Alamofire
import SDWebImage

class WelcomeMessageViewController: UIViewController {

    
    @IBOutlet weak var labelWelcomeTitle: UILabel!
    @IBOutlet weak var imageViewWelcome: UIImageView!
    @IBOutlet weak var labelWelcomeContent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelWelcomeTitle.text = Global.labelWelcomeTitle
        labelWelcomeContent.text = Global.labelWelcomeMessage
        
        let imageUrl = URL(string: Global.imageUrlWelcome)
        imageViewWelcome.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "logo.png"), options: SDWebImageOptions.progressiveDownload)
        
        loadWelcomeMessage()
    }
    
    func loadWelcomeMessage() {
        Alamofire.request(Global.urlParameterWelcomeMessage).responseJSON { response in
            // print("Places result:", response.result)
            
            if let result = response.result.value {
                let arrayData: NSArray = result as! NSArray
                for paramData: NSDictionary in arrayData as! [NSDictionary] {
                    let parameter = Parameter()
                    parameter.idParametro = paramData["idParametro"]! as! String
                    parameter.nombre = paramData["Nombre"]! as! String
                    parameter.valor = paramData["Valor"]! as! String
                    
                    self.labelWelcomeContent.text = Global.parseTextByLang(str: parameter.valor)
                    // add to params list
                }
                
                // persist data
                
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
