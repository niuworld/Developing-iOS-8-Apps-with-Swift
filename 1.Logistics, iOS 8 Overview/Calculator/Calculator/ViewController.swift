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
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
        display.text = display.text! + digit
        }  else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

