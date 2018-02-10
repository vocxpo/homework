//
//  ViewController.swift
//  MyFirstApp
//
//  Created by 王山鷹 on 2018/01/27.
//  Copyright © 2018年 ousanyo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var targetLable: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var roundLable: UILabel!
    
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score: Int = 0
    var round: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startNewGame()
        
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        mySlider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        mySlider.setThumbImage(thumbImageHighlighted, for: .highlighted)
//        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "TrackLeft")
        let trackLeftResizable = trackLeftImage
//            trackLeftImage.resizableImage(withCapInsets: insets)
        mySlider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = #imageLiteral(resourceName: "TrackRight")
        let trackRightResizable = trackRightImage
//            trackRightImage.resizableImage(withCapInsets: insets)
        mySlider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClick(_ sender: Any) {
       
        currentValue = lroundf(mySlider.value)
        
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference
        score += points
        
        let alert = UIAlertController(title: "Hello,World",
                                      message: "当前输入数值是：\(lroundf(mySlider.value))" +
                                                "target数值是：\(targetValue)" +
                                                "差：\(difference)",
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: "yes", style: .default,
                                   handler: { action in self.startNewRound()
                                    
                                            })
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print("slider is \(sender.value)")
        
    }
    
    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func startNewRound(){
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        mySlider.value = Float(currentValue)
        updateLabels()
        
    }
    
    func updateLabels() {
        targetLable.text = String(targetValue)
        scoreLable.text = String(score)
        roundLable.text = String(round)
        
    }
}

