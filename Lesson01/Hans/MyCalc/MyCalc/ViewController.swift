//
//  ViewController.swift
//  MyCalc
//
//  Created by dev on 2018/01/29.
//  Copyright © 2018年 oopx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnDivide: UIButton!
    @IBOutlet weak var btnMultiple: UIButton!
    @IBOutlet weak var btnSubstract: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    
    var curOp: String = ""
    var operand1: String = ""
    var operand2: String = ""
    var opJustTouched: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initResult()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initResult() {
        curOp = ""
        operand1 = ""
        operand2 = ""
        lblResult.text = "0"
        btnClear.setTitle("AC", for: .normal)
        initOpButtonStyle()
    }
    
    func setResult(numTouched: String) {
        let curNum: NSString = lblResult.text! as NSString
        
        if curOp == "" {
            if curNum.length < 12 {
                if numTouched == "0" {
                    if curNum != "0" {
                        lblResult.text = lblResult.text! + "0"
                        btnClear.setTitle("C", for: .normal)
                    } else {
                        btnClear.setTitle("AC", for: .normal)
                    }
                } else {
                    if curNum != "0" {
                        lblResult.text = lblResult.text! + numTouched
                    } else {
                        lblResult.text = numTouched
                        btnClear.setTitle("C",for: .normal)
                    }
                }
            }
            
            initOpButtonStyle()
        } else {
            if numTouched == "0" {
                if opJustTouched {
                    lblResult.text = "0"
                } else {
                    if curNum.length < 12 {
                        lblResult.text = lblResult.text! + "0"
                    }
                    btnClear.setTitle("AC", for: .normal)
                }
            } else {
                if opJustTouched {
                    lblResult.text = numTouched
                    opJustTouched = false
                } else {
                    if curNum.length < 12 {
                        lblResult.text = lblResult.text! + numTouched
                    }
                    btnClear.setTitle("C",for: .normal)
                }
            }
            
            initOpButtonStyle()
        }
    }
    
    func initOpButtonStyle() {
        btnAdd.setTitleColor(UIColor.white, for: .normal)
        btnAdd.backgroundColor = UIColor.orange
        btnSubstract.setTitleColor(UIColor.white, for: .normal)
        btnSubstract.backgroundColor = UIColor.orange
        btnMultiple.setTitleColor(UIColor.white, for: .normal)
        btnMultiple.backgroundColor = UIColor.orange
        btnDivide.setTitleColor(UIColor.white, for: .normal)
        btnDivide.backgroundColor = UIColor.orange
    }
    
    func setOpButtonStyle() {
        let btn: UIButton
        
        initOpButtonStyle()
        opJustTouched = true
        
        switch (curOp) {
        case "+":
            btn = btnAdd
        case "-":
            btn = btnSubstract
        case "*":
            btn = btnMultiple
        case "/":
            btn = btnDivide
        default:
            btn = btnAdd
        }
        
        btn.setTitleColor(UIColor.orange, for: .normal)
        btn.backgroundColor = UIColor.white
    }
    
    @IBAction func btnAddClick(_ sender: Any) {
        curOp = "+"
        operand1 = lblResult.text!
        setOpButtonStyle()
    }
    
    @IBAction func btnSubstractClick(_ sender: Any) {
        curOp = "-"
        operand1 = lblResult.text!
        setOpButtonStyle()
    }
    
    @IBAction func btnMultipleClick(_ sender: Any) {
        curOp = "*"
        operand1 = lblResult.text!
        setOpButtonStyle()
    }
    
    @IBAction func btnDivideClick(_ sender: Any) {
        curOp = "/"
        operand1 = lblResult.text!
        setOpButtonStyle()
    }
    
    @IBAction func btnEqualClick(_ sender: Any) {
        let op1: Double
        let op2: Double
        let res: Double
        let resStr: String
        
        if operand1 == "" { return }
        
        operand2 = lblResult.text!
        
        op1 = Double(operand1)!
        op2 = Double(operand2)!
        
        switch (curOp) {
        case "+":
            res = op1 + op2
        case "-":
            res = op1 - op2
        case "*":
            res = op1 * op2
        case "/":
            res = op1 / op2
        default:
            res = 0
        }
        
        resStr = String(res)
        
        if res.truncatingRemainder(dividingBy: 1) == 0 {
            lblResult.text = String(Int(res))
        } else {
            lblResult.text = String(resStr[..<resStr.index(resStr.startIndex, offsetBy: 12)])
        }

        curOp = "="
        opJustTouched = true
        operand1 = ""
        operand2 = ""
    }
    
    @IBAction func btnClearClick(_ sender: Any) {
        initResult()
    }
    
    @IBAction func btn0Click(_ sender: Any) {
        setResult(numTouched: "0")
    }
    
    @IBAction func btn1Click(_ sender: Any) {
        setResult(numTouched: "1")
    }
    
    @IBAction func btn2Click(_ sender: Any) {
        setResult(numTouched: "2")
    }
    
    @IBAction func btn3Click(_ sender: Any) {
        setResult(numTouched: "3")
    }
    
    @IBAction func btn4Click(_ sender: Any) {
        setResult(numTouched: "4")
    }
    
    @IBAction func btn5Click(_ sender: Any) {
        setResult(numTouched: "5")
    }
    
    @IBAction func btn6Click(_ sender: Any) {
        setResult(numTouched: "6")
    }
    
    @IBAction func btn7Click(_ sender: Any) {
        setResult(numTouched: "7")
    }
    
    @IBAction func btn8Click(_ sender: Any) {
        setResult(numTouched: "8")
    }
    
    @IBAction func btn9Click(_ sender: Any) {
        setResult(numTouched: "9")
    }
    
    @IBAction func btnDotClick(_ sender: Any) {
        lblResult.text = lblResult.text! + "."
    }
    
    @IBAction func btnPlusMinusClick(_ sender: Any) {
        let curNum: NSString = lblResult.text! as NSString
        let curNumStr: String = String(curNum)
        var sign: String = ""
        
        if curNum != "0" {
            sign = String(curNumStr[..<curNumStr.index(curNumStr.startIndex, offsetBy: 1)])
            
            if sign != "-" {
                if curNum.length < 12 {
                    lblResult.text = "-" + String(curNum)
                }
            } else {
                lblResult.text = String(curNumStr[curNumStr.index(curNumStr.startIndex, offsetBy: 1)...])
            }
        }
    }
    
    @IBAction func btnPercentageClick(_ sender: Any) {
        let curNum: NSString = lblResult.text! as NSString
        let res: Double = Double(String(curNum))! / 100
        let resStr: NSString = String(res) as NSString
        
        if resStr.length <= 12 {
            lblResult.text = String(res)
        }
    }
    
}

