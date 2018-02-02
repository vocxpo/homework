//
//  ViewController.swift
//  Pluser
//
//  Created by ebuser on 2018/02/02.
//  Copyright © 2018 ebuser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var screenLabel: UILabel!

    var currentDigit = 0
    var lastDigit = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clearButtonPressed(_ sender: Any) {
        lastDigit = 0
        currentDigit = 0
        screenLabel.text = "0"
    }

    @IBAction func plusButtonPressed(_ sender: Any) {
        lastDigit = currentDigit
        currentDigit = 0
    }

    @IBAction func equalButtonPressed(_ sender: Any) {
        lastDigit += currentDigit
        currentDigit = 0
        screenLabel.text = String(lastDigit)
    }

    @IBAction func digitButtonPressed(_ sender: UIButton) {
        currentDigit *= 10
        currentDigit += sender.tag
        screenLabel.text = String(currentDigit)
    }

}
