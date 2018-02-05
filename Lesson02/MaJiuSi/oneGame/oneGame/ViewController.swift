//
//  ViewController.swift
//  oneGame
//
//  Created by Margis on 2018/2/5.
//  Copyright © 2018年 Margis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Score: UILabel!
    @IBOutlet weak var Round: UILabel!
    @IBOutlet weak var Target: UILabel!
    @IBOutlet weak var slider: UISlider!
    var targetNumber = 0
    var currentNumber = 0
    var score = 0
    var scoreSum = 0
    var round = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Score.text = "得分：0"
        Round.text = "回合：0"
        slider.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Normal"), for: .normal)
        setTargetNumber()
        Target.text = "\(targetNumber)"
        slider.setMaximumTrackImage(#imageLiteral(resourceName: "TrackRight"), for: .normal)
        slider.setMinimumTrackImage(#imageLiteral(resourceName: "TrackLeft"), for: .normal)
    }
    @IBAction func sliderChanged(_ sender: UISlider) {
        sender.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Normal"), for: .normal)
        sender.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Highlighted"), for: .highlighted)
        currentNumber = lroundf(sender.value)
    }
    @IBAction func okClick(_ sender: Any) {
        currentNumber = lroundf(slider.value)
        if currentNumber == targetNumber {
            score = 100
            scoreSum += 100
        } else if abs(currentNumber-targetNumber) < 10{
            score = 80
            scoreSum += 80
        }else if abs(currentNumber-targetNumber) < 20{
            score = 50
            scoreSum += 50
        }else if abs(currentNumber-targetNumber) < 30{
            score = 25
            scoreSum += 25
        }else {
            score = 0
        }
        let alert = UIAlertController.init(title: "得分：", message: "结果：\(currentNumber) 本局得分为 \(score)", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        Score.text = "得分：\(scoreSum)"
        round += 1
        slider.value = 50
        Round.text = "回合：\(round)"
        setTargetNumber()
        Target.text = "\(targetNumber)"
    }
    @IBAction func resetClick(_ sender: Any) {
        currentNumber = 50
        round = 0
        score = 0
        scoreSum = 0
        slider.value = 50
        Score.text = "得分：0"
        Round.text = "回合：0"
        setTargetNumber()
        Target.text = "\(targetNumber)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setTargetNumber(){
        targetNumber = Int(1 + arc4random_uniform(100))
    }

}

