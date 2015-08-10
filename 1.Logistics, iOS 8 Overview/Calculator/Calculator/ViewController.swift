//
//  ViewController.swift
//  Calculator
//
//  Created by 牛野 on 15/7/24.
//  Copyright (c) 2015年 Noah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    var brain = CalculateBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
        display.text = display.text! + digit
        }  else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        updateHistory()
    }
    
    @IBAction func BackDelete() {
        if userIsInTheMiddleOfTypingANumber{
            resetDisplay()
        }
        updateHistory()
    }
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            } else{
                displayValue = 0
            }
        }
        updateHistory()
    }
    

    @IBAction func SetM() {
        brain.variableValues["M"] = displayValue
        if let result = brain.evaluate(){
            displayValue = result
        }else{
            displayValue = nil
        }
        updateHistory()
    }
    
    @IBAction func PushM() {
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        if let result = brain.pushOperand("M"){
            displayValue = result
        }else {
            displayValue = nil
        }
        updateHistory()
        
    }
    
    //    var operandStack: Array<Double> = Array<Double>()
    func resetDisplay(){
        display.text = "0"
        userIsInTheMiddleOfTypingANumber = false
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false

        if let result = brain.pushOperand(displayValue!){
            displayValue = result
        } else{
            resetDisplay()
        }
        updateHistory()
    }
    
    @IBAction func clearAll() {
        brain.clearDisplay()
        resetDisplay()
        updateHistory()
        
    }
    var displayValue: Double?  {
        get{
            if let displayText = display.text{
            return  NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            }
            return nil
        }
        set{
            if let newNumber = newValue{
              display.text = "\(newNumber)"

            } else{
               display.text = nil
            }
        userIsInTheMiddleOfTypingANumber = false
        }
    }

    func updateHistory(){
        history.text = brain.description + (!userIsInTheMiddleOfTypingANumber&&brain.lastOpIsAnOperation ? "=":"")
    }
}

