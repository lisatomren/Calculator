//
//  File.swift
//  Calculator
//
//  Created by Lisa Tomren Kjørli on 13/11/16.
//  Copyright © 2016 Lisa Tomren Kjørli. All rights reserved.
//

import Foundation

class CalculatorBrain{
    
    private var accumulator = 0.0
    private var pending: PendingBinaryOperationInfo?
    
    
    //set and get for accumulator
     var result: Double{
        get{
            return accumulator
        }
        set{
            accumulator = newValue
        }
    }
    
    
    var operations: Dictionary<String,Operation> = [
        "π": Operation.Constant(M_PI),
        "√" : Operation.UnaryOperation(sqrt),
        "+" : Operation.BinaryOperation( {$0 + $1}), //closure example
        "-" : Operation.BinaryOperation( {$0 - $1}),
        "x" : Operation.BinaryOperation({$0 * $1}),
        "=" : Operation.Equals
    ]
    
    
    //enum can contain funcs
    enum Operation{
        case Constant(Double)
        case UnaryOperation((Double) -> Double)//function
        case BinaryOperation((Double,Double) -> Double ) // closure example
        case Equals
    }
    
    
    func performOperation(symbol: String ) {
        if let operation = operations[symbol]{
            switch operation{
            case .Constant(let value) :
                accumulator = value
            case .UnaryOperation(let function) :
                accumulator = function(accumulator)
            case .BinaryOperation(let function) :
                excecutePendingOperation()
                pending = PendingBinaryOperationInfo( binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                excecutePendingOperation()
                
            }
        }
    }
    
    private func excecutePendingOperation()
    {
        if pending != nil
        {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    
    struct PendingBinaryOperationInfo{
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
}
