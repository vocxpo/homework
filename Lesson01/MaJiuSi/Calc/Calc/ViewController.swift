//
//  ViewController.swift
//  Calc
//
//  Created by 马九思 on 2018/1/27.
//  Copyright © 2018年 Maiasoft. All rights reserved.
//

import UIKit
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
class ViewController: UIViewController {
    var number:Float32 = 0
    var result:Float32 = 0
    var point:Bool = false
    var action = ""
    @IBOutlet weak var resultTextBox: UILabel!
    @IBOutlet weak var number1link: UIButton!
    @IBOutlet weak var number2link: UIButton!
    @IBOutlet weak var number3link: UIButton!
    @IBOutlet weak var number4link: UIButton!
    @IBOutlet weak var number5link: UIButton!
    @IBOutlet weak var number6link: UIButton!
    @IBOutlet weak var number7link: UIButton!
    @IBOutlet weak var number8link: UIButton!
    @IBOutlet weak var number9link: UIButton!
    @IBOutlet weak var number0link: UIButton!
    @IBOutlet weak var pluslink: UIButton!
    @IBOutlet weak var sublink: UIButton!
    @IBOutlet weak var multlink: UIButton!
    @IBOutlet weak var divlink: UIButton!
    @IBOutlet weak var equallink: UIButton!
    @IBOutlet weak var clink: UIButton!
    @IBOutlet weak var pointlink: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func number1Click(_ sender: Any) {
        numberClick(inputValue: 1)
        number1link.backgroundColor = UIColor(red: 66, green: 66, blue: 66)
    }
    @IBAction func number2Click(_ sender: Any) {
        numberClick(inputValue: 2)
        number2link.backgroundColor = UIColor(red: 66, green: 66, blue: 66)
    }
    @IBAction func number3Click(_ sender: Any) {
        numberClick(inputValue: 3)
        number3link.backgroundColor = UIColor(red: 66, green: 66, blue: 66)
    }
    @IBAction func number4Click(_ sender: Any) {
        numberClick(inputValue: 4)
        number4link.backgroundColor = UIColor(red: 66, green: 66, blue: 66)
    }
    @IBAction func number5Click(_ sender: Any) {
        numberClick(inputValue: 5)
        number5link.backgroundColor = UIColor(red: 66, green: 66, blue: 66)
    }
    @IBAction func number6Click(_ sender: Any) {
        numberClick(inputValue: 6)
        number6link.backgroundColor = UIColor(red: 66, green: 66, blue: 66)
    }
    @IBAction func number7Click(_ sender: Any) {
        numberClick(inputValue: 7)
        number7link.backgroundColor = UIColor(red: 66, green: 66, blue: 66)
    }
    @IBAction func number8Click(_ sender: Any) {
        numberClick(inputValue: 8)
        number8link.backgroundColor = UIColor(red: 66, green: 66, blue: 66)
    }
    @IBAction func number9Click(_ sender: Any) {
        numberClick(inputValue: 9)
        number9link.backgroundColor = UIColor(red: 66, green: 66, blue: 66)
    }
    @IBAction func number0Click(_ sender: Any) {
        numberClick(inputValue: 0)
        number0link.backgroundColor = UIColor(red: 66, green: 66, blue: 66)
    }
    @IBAction func pointClick(_ sender: Any) {
        point = true
        pointlink.backgroundColor = UIColor(red: 66, green: 66, blue: 66)
    }
    @IBAction func funcPlus(_ sender: Any) {
        clearColor()
        calClick(inputCalc: "+")
        pluslink.backgroundColor = UIColor(red: 200, green: 200, blue: 200)
        point = false
    }
    @IBAction func funcSub(_ sender: Any) {
        clearColor()
        calClick(inputCalc: "-")
        sublink.backgroundColor = UIColor(red: 200, green: 200, blue: 200)
        point = false
    }
    @IBAction func funcMult(_ sender: Any) {
        clearColor()
        calClick(inputCalc: "×")
        multlink.backgroundColor = UIColor(red: 200, green: 200, blue: 200)
        point = false
    }
    @IBAction func funcDiv(_ sender: Any) {
        clearColor()
        calClick(inputCalc: "÷")
        divlink.backgroundColor = UIColor(red: 200, green: 200, blue: 200)
        point = false
    }
    @IBAction func funcEqual(_ sender: Any) {
        calc()
        printResult()
        clearColor()
        equallink.backgroundColor = UIColor(red: 253, green: 148, blue: 38)
        point = false
    }
    @IBAction func clearClick(_ sender: Any) {
        number = 0
        result = 0
        action = ""
        printResult()
        clearColor()
        clink.backgroundColor = UIColor(red: 253, green: 148, blue: 38)
        point = false
    }
    @IBAction func number1Down(_ sender: Any) {
        number1link.backgroundColor = UIColor(red: 45, green: 45, blue: 45)
    }
    @IBAction func number2Down(_ sender: Any) {
        number2link.backgroundColor = UIColor(red: 45, green: 45, blue: 45)
    }
    @IBAction func number3Down(_ sender: Any) {
        number3link.backgroundColor = UIColor(red: 45, green: 45, blue: 45)
    }
    @IBAction func number4Down(_ sender: Any) {
        number4link.backgroundColor = UIColor(red: 45, green: 45, blue: 45)
    }
    @IBAction func number5Down(_ sender: Any) {
        number5link.backgroundColor = UIColor(red: 45, green: 45, blue: 45)
    }
    @IBAction func number6Down(_ sender: Any) {
        number6link.backgroundColor = UIColor(red: 45, green: 45, blue: 45)
    }
    @IBAction func number7Down(_ sender: Any) {
        number7link.backgroundColor = UIColor(red: 45, green: 45, blue: 45)
    }
    @IBAction func number8Down(_ sender: Any) {
        number8link.backgroundColor = UIColor(red: 45, green: 45, blue: 45)
    }
    @IBAction func number9Down(_ sender: Any) {
        number9link.backgroundColor = UIColor(red: 45, green: 45, blue: 45)
    }
    @IBAction func pointDown(_ sender: Any) {
        pointlink.backgroundColor = UIColor(red: 45, green: 45, blue: 45)
    }
    @IBAction func number0Down(_ sender: Any) {
        number0link.backgroundColor = UIColor(red: 45, green: 45, blue: 45)
    }
    @IBAction func cDown(_ sender: Any) {
        clink.backgroundColor = UIColor(red: 66, green: 66, blue: 66)
    }
    @IBAction func equalDown(_ sender: Any) {
        equallink.backgroundColor = UIColor(red: 66, green: 66, blue: 66)
    }
    
    func numberClick(inputValue x:Float32){
        if point{
            
        }else{
            number = number*10 + x
        }
        printnumber()
        clearColor()
    }
    func calClick(inputCalc y:String){
        switch y {
        case "+":
            if(action != ""){
                calc()
            }
            action = "+"
            if(number != 0 && result != 0){
                result = result + number
                print(result)
                printResult()
                number = 0
            } else if (number != 0){
                result = number
                number = 0
            }
        case "-":
            if(action != ""){
                calc()
            }
            action = "-"
            if(number != 0 && result != 0){
                result = result - number
                printResult()
                number = 0
            } else if (number != 0){
                result = number
                number = 0
            }
        case "×":
            if(action != ""){
                calc()
            }
            action = "×"
            if(number != 0 && result != 0){
                result = result * number
                printResult()
                number = 0
            } else if (number != 0){
                result = number
                number = 0
            }
        case "÷":
            if(action != ""){
                calc()
            }
            action = "÷"
            if(number != 0 && result != 0){
                result = result / number
                printResult()
                number = 0
            } else if (number != 0){
                result = number
                number = 0
            }
        default:
            break
        }
    }
    func printnumber(){
        if number - floorf(number)==0.0{
            resultTextBox.text = "\(Int(number))"
        }else{
            resultTextBox.text = "\(number)"
        }

    }
    func calc(){
        switch action {
        case "+":
            result = result + number
        case "-":
            result = result - number
        case "×":
            result = result * number
        case "÷":
            result = result / number
        default:
            break
        }
        action = ""
        number = 0
    }
    func printResult(){
        if result - floorf(result)==0.0{
            resultTextBox.text = "\(Int(result))"
        }else{
        resultTextBox.text = "\(result)"
        }
    }
    func clearColor(){
        pluslink.backgroundColor = UIColor(red: 253, green: 148, blue: 38)
        sublink.backgroundColor = UIColor(red: 253, green: 148, blue: 38)
        multlink.backgroundColor = UIColor(red: 253, green: 148, blue: 38)
        divlink.backgroundColor = UIColor(red: 253, green: 148, blue: 38)
    }
}

