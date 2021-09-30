//
//  ViewController.swift
//  SimpleCalculator
//
//  Created by Kaushal Subedi on 11/22/15.
//  Copyright © 2015 Kaushal Subedi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Type of available operations
    enum Operations: String{
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Divide = "/"
        case None = ""
    }
    
    // Stores the last number that was entered
    var lastNumber: Double = 0
    // Stores the last operation that was done
    var lastOperation: Operations = Operations.None
    // Checks if an operation is active (if the last pressed button was an operation)
    var operationActive = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Output label to print results to
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBAction func numberPressed(num: UIButton!){
        // Get the current number from the output label
        var currentNumbers = outputLabel.text!
        
        // Get which number was pressed
        var pressedNumber = num.titleLabel!.text!
        
        // If the current value is 0, dont append, start new. Also let multiple zeros after a decimal
        if Double(currentNumbers) == 0 && !currentNumbers.containsString("."){
            currentNumbers = ""
            
            // If there is nothing on the screen, make sure it types 0 instead of 00
            if Double(pressedNumber) == 0{
                pressedNumber = "0"
            }
        }
        
        // If an operation is active (if the last pressed key was an operation), start over on the label
        if operationActive{
            currentNumbers = ""
        }
        
        // Make sure people don't press the . twice in one number
        if pressedNumber == "." && currentNumbers.containsString("."){
            pressedNumber = ""
        }
        
        // Append to the label
        outputLabel.text = "\(currentNumbers)\(pressedNumber)"
        
        // If a number is pressed, operations are not active since the last pressed key was a number
        operationActive = false
    }
    
    @IBAction func operatorPressed(op: UIButton!){
        // Get the type of operation pressed
        let opPressed = op.tag
        
        switch opPressed{
        case 0:
            performOperation(Operations.Add)
        case 1:
            performOperation(Operations.Subtract)
        case 2:
            performOperation(Operations.Divide)
        case 3:
            performOperation(Operations.Multiply)
        default:
            print("No Operations")
        }
        
    }
    
    @IBAction func equalsPressed(btn: UIButton!){
        // Perform an none operation
        performOperation(Operations.None)
    }
    
    // Clears everything and resets things on screen
    @IBAction func clearPressed(btn: UIButton!){
        outputLabel.text =  "0"
        lastNumber = 0
        lastOperation = Operations.None
    }
    

    
    func performOperation(op: Operations){
        // Grab current number from the output label
        let currentNumber = Double(outputLabel.text!)!
        
        // Set initial value for result
        var result: Double = 0
        
        if lastNumber == 0 && lastOperation == Operations.None{ // Runs if the program just started
            lastNumber = currentNumber
            lastOperation = op
        }else if !operationActive{ // If no other operation is active, runs
            switch lastOperation{
            case Operations.Add:
                result = lastNumber + currentNumber
            case Operations.Subtract:
                result = lastNumber - currentNumber
            case Operations.Multiply:
                result = lastNumber * currentNumber
            case Operations.Divide:
                result = lastNumber / currentNumber
            case Operations.None:
                result = lastNumber
            }
            
            // Hack to round the result double
            result = Double(round(10000000*result)/10000000)
            
            // Set the output label to result value
            outputLabel.text = String(result)
            
            // Set the last number to result value
            lastNumber = result
            
            // Set the last operation to the operation last done
            lastOperation = op
        }else if operationActive{ // If an operation is active, change the operation type
            lastOperation = op
        }
        
        // Set operation active to true
        operationActive = true
    }
    


}

