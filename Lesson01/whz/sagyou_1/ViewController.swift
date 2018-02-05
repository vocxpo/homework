//
//  ViewController.swift
//  sagyou_1
//
//  Created by 王 on 2018/1/27.
//  Copyright © 2018年 王. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var operandStart: Int = 0
    var operandEnd: Int = 0
    var operandN: Int = 0
    var resultG: Int = 0
    var isEnd: Bool = false
    var operatorFlag: String = ""
    
    
    @IBAction func clear(_ sender: UIButton) {
        
        display.text = "0"
        operandStart = 0
        operandEnd = 0
        operandN = 0
        resultG = 0
        isEnd = false
        operatorFlag = ""
    }
    
    
    @IBAction func countTap(_ sender: UIButton) {
        
        if (isEnd && (operatorFlag != "")) {
            display.text = resultG.description
            resultG = 0;
        }
        isEnd = true
        
        switch sender.currentTitle! {
        case "+":
            operatorFlag = "+"
        case "-":
            operatorFlag = "-"
        case "*":
            operatorFlag = "*"
        case "/":
            operatorFlag = "/"
        default:
            operatorFlag = ""
        }
        print("operatorFlag: \(operatorFlag)")
    }
    
    
    @IBAction func resultTap(_ sender: UIButton) {
        
        if isEnd {
            if ((operatorFlag == "/") && ((operandEnd == 0) || (operandN == 0))) {
                print("Error: 除数不能为0")
                return
            }

            display.text = resultG.description
            print("操作开始: \(operandStart)")
            print("操作符: \(operatorFlag)")
            print("操作结束: \(operandEnd)")
            print("计算结果: \(resultG)")
        }
    }
    
    
    @IBAction func onClick(_ sender: UIButton) {
        
        if ((display.text == "0") || (isEnd && (operandEnd == 0))) {
            display.text = ""
        }
        if operatorFlag == "" {
            display.text = display.text! + sender.currentTitle!
        } else {
            display.text = sender.currentTitle!
        }
        
        if isEnd {
            operandN = operandN + operandEnd
            operandEnd = NSString(string: display.text!).integerValue
            saiCount()
        } else {
            operandStart = NSString(string: display.text!).integerValue
        }
        print("操作开始值: \(operandStart)")
        print("操作中间值: \(operandN)")
        print("操作结束值: \(operandEnd)")
    }
    
    private func saiCount() {
        
        switch operatorFlag {
        case "+":
            resultG = operandStart + operandN + operandEnd
        case "-":
            resultG = operandStart - operandN - operandEnd
        case "*":
            resultG = operandStart * operandN * operandEnd
        case "/":
            if ((operandN != 0) && (operandEnd != 0)) {
                resultG = operandStart / operandN / operandEnd
            }
        default:
            resultG = 0
        }
    }
}

