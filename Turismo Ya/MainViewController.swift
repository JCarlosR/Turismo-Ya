//
//  ViewController.swift
//  Turismo Ya
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import ImageSlideshow
import RealmSwift
import Alamofire

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // hide the back button (when it comes from exit option menu)
        self.navigationItem.hidesBackButton = true
        
        // add border to btnLogin
        // btnLogin.backgroundColor = .clear
        btnLogin.layer.cornerRadius = 17
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.borderColor = UIColor.black.cgColor
        
        configureSlideshow()
        // preloadData()
    }
    
    /*func preloadData() {
        if Connectivity.isConnectedToInternet() {
            Alamofire.request(Global.urlCityPlaceRelations).responseJSON { response in
                
                if let result = response.result.value {
                    
                    let arrayData: NSArray = result as! NSArray
                    let realm = try! Realm()
                    
                    try! realm.write {
                        let result = realm.objects(CiudadProducto.self)
                        realm.delete(result)
                    }
                    
                    for itemData: NSDictionary in arrayData as! [NSDictionary] {
                        let cityPlace = CiudadProducto()
                        cityPlace.idCiudad = itemData["idCiudad"]! as! String
                        cityPlace.idProducto = itemData["idProducto"]! as! String
                        try! realm.write {
                            realm.add(cityPlace)
                        }
                    }
                }
            }
        }
    }*/
    
    func configureSlideshow() {
        slideshow.setImageInputs([
            ImageSource(image: UIImage(named: "p_trujillo.jpg")!),
            ImageSource(image: UIImage(named: "p_pacasmayo.jpg")!),
            ImageSource(image: UIImage(named: "p_julcan.jpg")!),
            // AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080"),
        ])
        slideshow.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.07)
        slideshow.slideshowInterval = 2
    }
    
    /*
    func setupVideoBackground() {
        // Adds a black overlay to the looped video in question
        blackOverlay = UIView(frame: UIScreen.main.bounds)
        blackOverlay.backgroundColor = UIColor(white: 1, alpha: 0.5)
        blackOverlay.layer.zPosition = 0
        blackOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blackOverlay, at: 0)
        
        // begin implementing the avplayer
        player = AVPlayer(url: videoURL as URL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        
        playerLayer.frame = view.frame
        
        self.view.layer.addSublayer(playerLayer)
        
        player?.play()
        
        // add observer to watch for video end in order to loop video
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.loopVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player)
    }
    
    func loopVideo() {
        player?.seek(to: kCMTimeZero)
        player?.play()
    }
    
    // if video ends, will restart    
    func playerItemDidReachEnd() {
        player!.seek(to: kCMTimeZero)
    }
    */
 
 
    @IBAction func btnLoginPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "enterToLoginSegue", sender: self)
    }
    
    
    @IBAction func btnRegisterPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "enterToRegisterSegue", sender: self)
    }

    @IBAction func btnSkipPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "enterToMenuSegue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

