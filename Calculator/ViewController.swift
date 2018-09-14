//
//  ViewController.swift
//  Calculator
//
//  Created by sangjin park on 2018. 9. 13..
//  Copyright © 2018년 Loguin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit  = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let currentlyInDisplay = display.text!
            display.text = currentlyInDisplay + digit
        }
        else{
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true;
    }
    
    private var displayValue : Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    private var brain  = CalculatorBrain()
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperation(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if  let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
}


