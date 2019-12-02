//
//  ViewController.swift
//  MyFirstApp
//
//  Created by dev on 2018/01/27.
//  Copyright © 2018年 oopx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sliderNumber: UISlider!
    @IBOutlet weak var labelTarget: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelRound: UILabel!
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score: Int = 0
    var rounds: Int = 0
    var scoreAdded: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sliderNumber.setThumbImage(#imageLiteral(resourceName: "slider"), for: .normal)
        sliderNumber.setThumbImage(#imageLiteral(resourceName: "slider_highlighted"), for: .highlighted)
        sliderNumber.setMinimumTrackImage(#imageLiteral(resourceName: "slider_track_01"), for: .normal)
        sliderNumber.setMaximumTrackImage(#imageLiteral(resourceName: "slider_track_02"), for: .normal)

        startNewRound()
    }
    
    func startNewRound() {
        rounds += 1
        
        targetValue = 1 + Int(arc4random_uniform(100))
        labelTarget.text = "\(targetValue)"
        labelScore.text = "\(score)"
        labelRound.text = "\(rounds)"
        
        scoreAdded = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonResultClick(_ sender: Any) {
        currentValue = lroundf(sliderNumber.value)
        let s = lroundf(Float(targetValue - abs(currentValue - targetValue)) / Float(targetValue) * 100)
        
        let alert = UIAlertController(title: "RESULT",
                                      message: "Target: \(targetValue)\n" +
                                               "You slided to: \(currentValue)\n" +
                                               "Your score: \(s)",
                                      preferredStyle: .alert)
        
        if !scoreAdded {
            score += s
            labelScore.text = "\(score)"
            scoreAdded = true
        }

        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        let action2 = UIAlertAction(title: "New Round", style: .default, handler: {(alert: UIAlertAction!) in self.startNewRound()})

        alert.addAction(action)
        alert.addAction(action2)
        
        // self.present
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderNumberValueChanged(_ sender: UISlider) {
        print("Slider is: \(sender.value)")
    }
    
    @IBAction func buttonRetryClick(_ sender: Any) {
        startNewRound()
    }
}
