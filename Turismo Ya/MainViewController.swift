//
//  ViewController.swift
//  Turismo Ya
//
//  Created by rimenri on 19/02/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import ImageSlideshow

class MainViewController: UIViewController {
    
    /*
    // add transparency using a programatically created view
    var blackOverlay: UIView!
    
    var player: AVPlayer?
    let videoURL: NSURL = Bundle.main.url(forResource: "intro", withExtension: "mp4")! as NSURL
    */
    
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSlideshow()
        
        // un-comment to show the video background again
        // setupVideoBackground()
    }
    
    func configureSlideshow() {
        slideshow.setImageInputs([
            ImageSource(image: UIImage(named: "p_trujillo.jpg")!),
            ImageSource(image: UIImage(named: "p_pacasmayo.jpg")!),
            ImageSource(image: UIImage(named: "p_julcan.jpg")!),
            // AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080"),
        ])
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

