//
//  ViewController.swift
//  Calculator
//
//  Created by Lisa Tomren Kjørli on 13/11/16.
//  Copyright © 2016 Lisa Tomren Kjørli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet private weak var display: UILabel!
    
    private var brain = CalculatorBrain()
    private var userIsInTheMiddleOfTyping = false
    
    
    //set and get for label
    private var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)//parameter to set, name needs to be "newValue"?
        }
    }
    
    
    //******** LISTENERS ********//
    
    //digit tapped
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping
        {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else{
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    
    //symbol tapped
    @IBAction func performOperation(_ sender: UIButton) {
            if userIsInTheMiddleOfTyping{
                brain.result = displayValue
                //brain.setOperand(operand: displayValue)
                userIsInTheMiddleOfTyping = false
            }
        
        //if let - because then we handle if the currentTitle is not set
            if let mathematicalSymbol = sender.currentTitle{
                brain.performOperation(symbol: mathematicalSymbol)
            }
     
        displayValue = brain.result
        }
 
    
}

