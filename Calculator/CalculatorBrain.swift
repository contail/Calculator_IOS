//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by sangjin park on 2018. 9. 14..
//  Copyright © 2018년 Loguin. All rights reserved.
//

import Foundation
class CalculatorBrain{
    
    private var accumlator = 0.0
    private var internalProgram = [AnyObject]()
    func setOperation(operand: Double) {
        accumlator = operand
        internalProgram.append(operand as AnyObject)
        
    }
    private var operations : Dictionary <String, Operations> = [
        "π" : Operations.Constans(Double.pi),
        "√" : Operations.UnaryOperations(sqrt),
        "cos" : Operations.UnaryOperations(cos),
        "e" : Operations.Constans(M_E),
        "×" : Operations.BinaryOperations({$0 * $1}),
        "+" : Operations.BinaryOperations({$0 + $1}),
        "-" : Operations.BinaryOperations({$0 - $1}),
        "÷" : Operations.BinaryOperations({$0 / $1}),
        "=" : Operations.Equals,
        ]
    
     func performOperation(symbol : String){
        internalProgram.append(symbol as AnyObject)
        if let operation = operations[symbol]{
            switch operation{
            case .Constans(let value) :
                accumlator = value
            case .BinaryOperations(let foo):
                excutePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: foo, firstOperand: accumlator)
            case .UnaryOperations(let foo) :
                accumlator = foo(accumlator)
            case .Equals :
                excutePendingBinaryOperation()
            }
        }
        
    }
    private func excutePendingBinaryOperation(){
        if pending != nil{
            accumlator = pending!.binaryFunction(pending!.firstOperand,accumlator)
            pending = nil
        }
    }
    private var pending : PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction : (Double, Double) -> Double
        var firstOperand : Double
    }
    
    typealias PropertyList = AnyObject
//    var program : PropertyList{
//        get{
//            return internalProgram as CalculatorBrain.PropertyList
//        }
//        set{
//            clear()
//            if let arrayOfOps = newValue as? [AnyObject]{
//                for op in arrayOfOps{
//                    if let operand
//                }
//            }
//        }
//    }
    
    private func clear(){
        accumlator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    private enum Operations {
        case Constans(Double)
        case UnaryOperations((Double) -> Double)
        case BinaryOperations((Double, Double) -> Double)
        case Equals
    }
    
    var result : Double {
        get{
            return accumlator
        }
    }
    
}
