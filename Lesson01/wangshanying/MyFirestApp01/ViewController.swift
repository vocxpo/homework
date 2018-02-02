//
//  ViewController.swift
//  MyFirestApp01
//
//  Created by 王山鷹 on 2018/01/28.
//  Copyright © 2018年 王山鷹. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //表示用Label
    @IBOutlet weak var displayLabel: UILabel!
    //計算変数
    var firstNumber:String = ""
    var secondNumber:String = ""
    var currentOperator = Operators.Empty
    var displayNumber:String = ""
    var answerNumber:String = ""
    //計算符号
    enum Operators: String {
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Divide = "/"
        case Empty = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        displayLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // "＋"
    @IBAction func doAdd(_ sender: UIButton) {
        doOperator(operation: Operators.Add)
    }
    // "-"
    @IBAction func doSubtract(_ sender: UIButton) {
        doOperator(operation: Operators.Subtract)
    }
    // "*"
    @IBAction func doMultiply(_ sender: UIButton) {
        doOperator(operation: Operators.Multiply)
    }
    // "/"
    @IBAction func doDivide(_ sender: UIButton) {
        doOperator(operation: Operators.Divide)
    }
    //
    @IBAction func countAnswer(_ sender: UIButton) {
        doOperator(operation: currentOperator)
    }
    //入力数字
    @IBAction func countInput(_ sender: UIButton) {
        displayNumber += String(sender.tag)
        displayLabel.text = displayNumber
//        let alert = UIAlertController(title: "\(displayLabel.text)", message: "bbbbbbb", preferredStyle: .alert)
//       let action = UIAlertAction(title: "yes", style: .default, handler: nil)
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
        
    }
    //計算符号判断
    func doOperator(operation: Operators){
        
        
        if currentOperator != Operators.Empty {
            
            if displayNumber != "" {
                secondNumber = displayNumber
                displayNumber = ""
            }

            
            switch currentOperator {
                case Operators.Add:
                    answerNumber = String(Double(firstNumber)! + Double(secondNumber)!)
                case Operators.Subtract:
                    answerNumber = String(Double(firstNumber)! - Double(secondNumber)!)
                case Operators.Multiply:
                    answerNumber = String(Double(firstNumber)! * Double(secondNumber)!)
                case Operators.Divide:
                    answerNumber = String(Double(firstNumber)! / Double(secondNumber)!)
                default:
                    print("error")
                }
            firstNumber = answerNumber
            displayLabel.text = answerNumber
            currentOperator = operation

            
        } else {
            firstNumber = displayNumber
            displayNumber = ""
            currentOperator = operation
        }


    }
    //クリア
    @IBAction func countClear(_ sender: UIButton) {
        displayNumber = ""
        firstNumber = ""
        secondNumber = ""
        currentOperator = Operators.Empty
        displayLabel.text = displayNumber
    }
    
}

