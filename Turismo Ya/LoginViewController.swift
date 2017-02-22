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

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!    
    @IBOutlet weak var txtPassword: UITextField!
    
    // init video background and its path
    @IBOutlet var blackOverlay: UIView!
    
    var player: AVPlayer?
    let videoURL: NSURL = Bundle.main.url(forResource: "intro", withExtension: "mp4")! as NSURL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVideoBackground()
    }
    
    func setupVideoBackground() {
        // Adds a black overlay to the looped video in question
        blackOverlay.alpha = 0.50;
        blackOverlay.layer.zPosition = 0;
        
        // begin implementing the avplayer
        player = AVPlayer(url: videoURL as URL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        
        playerLayer.frame = view.frame
        
        view.layer.addSublayer(playerLayer)
        
        player?.play()
        
        // add observer to watch for video end in order to loop video
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.loopVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player)
    }
    
    func loopVideo() {
        player?.seek(to: kCMTimeZero)
        player?.play()
    }
    
    // if video ends, will restart    
    func playerItemDidReachEnd() {
        player!.seek(to: kCMTimeZero)
    }
    
    @IBAction func btnLoginPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "enterToMenuSegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

