//
//  ViewController.swift
//  Egg Timer
//
//  Created by Shahzaib Mumtaz on 22/08/2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    let eggTimes = ["Soft": 300, "Medium": 480, "Hard": 720]
    
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    var player : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView.progress = 0.0
    }

    @IBAction func Hardness(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progressView.progress = 0.0
        secondPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondPassed < totalTime {
            
            secondPassed += 1
            progressView.progress = Float(secondPassed) / Float(totalTime)
            
        }
        else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: ".mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}

