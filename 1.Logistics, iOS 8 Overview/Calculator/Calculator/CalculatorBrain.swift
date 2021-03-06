//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 牛野 on 15/7/26.
//  Copyright (c) 2015年 Noah. All rights reserved.
//

import Foundation

class CalculateBrain {
    private enum Op: Printable
    {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String,(Double, Double) -> Double)
        case ConstantOperation(String, () -> Double)
        case VariableOperation(String)
        
        var isOperation: Bool {
            switch self {
            case .UnaryOperation,  .BinaryOperation :
               return true
            default:
                return false
            }
        }
        
       var description: String{  //property: convert enum to string
        get{
            switch self {
            case .Operand(let operand):
                return "\(operand)"
            case .UnaryOperation(let symbol, _):
                return symbol
            case .BinaryOperation(let symbol, _):
                return symbol
          case .ConstantOperation(let constantName, _):
               return constantName
            case .VariableOperation(let variableName):
                return variableName
            }
          }
       }
  }
  private  var opStack = [Op]()
    
   private var knownOps = [String:Op]()
    
    init(){
        func learnOp(op: Op){
    knownOps[op.description] = op
     }
        
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("÷", { $1 / $0}))
        learnOp(Op.BinaryOperation("−", { $1 - $0}))
        learnOp(Op.UnaryOperation("sin", sin))
        learnOp(Op.UnaryOperation("cos", cos))
        learnOp(Op.UnaryOperation("√", sqrt))
        learnOp(Op.ConstantOperation("Ԉ", {M_PI}))
    }
    
   private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op])
    {
          if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation( _, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result{
                return (operation(operand), operandEvaluation.remainingOps)
              }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result{
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            case .ConstantOperation(_,let operation):
               // return (M_PI, remainingOps)
                 return ( operation() ,remainingOps)
            case .VariableOperation(let variableName):
            if let variableValue = variableValues[variableName]{
            return(variableValue, remainingOps)
             }
        return (nil, remainingOps)
          }
        }
   return (nil, ops)
    }
    
    var description: String {
        get{
            var description: String? = nil
            var remainingOps = opStack
            while(!remainingOps.isEmpty){
                let ( result, remainder) = evaluateDescription(remainingOps)
                if ( result != nil){
                    description =  description != nil ? "\(result!), \(description!)": "\(result!)"
                }
                remainingOps = remainder
            }
            return description != nil ? description!:" "
        }
    }
    
   private func evaluateDescription(ops:[Op]) -> (result: String?, remainingOps:[Op]){
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            var descriptionPart = ""
            switch op{
            case .Operand(let operand):
                descriptionPart = "\(operand)"
            case .VariableOperation(let symbol):
                descriptionPart = "\(symbol)"
            case .ConstantOperation(let symbol,_):
                descriptionPart = "\(symbol)"
            case .UnaryOperation(let symbol, _ ):
                let evaluated1 = remainingOps.isEmpty ? ( result: "?", remainingOps :remainingOps):evaluateDescription(remainingOps)
                remainingOps = evaluated1.remainingOps
                descriptionPart = "\(symbol)(\(evaluated1.result!))"
            case .BinaryOperation(let symbol, _):
                let evaluated2 = remainingOps.isEmpty ?( result: "?", remainingOps: remainingOps): evaluateDescription(remainingOps)
                remainingOps = evaluated2.remainingOps
                let evaluted3 = remainingOps.isEmpty ? ( result: "?", remainingOps: remainingOps):evaluateDescription(remainingOps)
                remainingOps = evaluted3.remainingOps
                var evaluated2Result = evaluated2.result!
                if ( symbol == "×" || symbol == "÷") && ( evaluated2Result.rangeOfString("−") != nil || evaluated2Result.rangeOfString("+") != nil ){
                    evaluated2Result = "(" + evaluated2Result + ")"
                }
                descriptionPart = "\(evaluted3.result!)\(symbol)\(evaluated2Result)"
            }
            return ( descriptionPart, remainingOps)
        }
        return (nil, ops)
        
    }
    
    var lastOpIsAnOperation: Bool{
        get{
            return opStack.count > 0 && opStack[opStack.endIndex - 1].isOperation
        }
    }
    
    
    
   func evaluate()-> Double?
    {
     let (result, remainder) = evaluate(opStack)
        print("\(opStack) = \(result) with \(remainder) left over \n")
        return result
    }
    
    func pushOperand(operand: Double) -> Double?{
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    func performOperation(symbol: String) -> Double?{
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
        return evaluate()
    }
    
    func pushOperand(operandVariable: String) -> Double?{
         let variable = Op.VariableOperation(operandVariable)
        opStack.append(variable)
        return evaluate()
    }
    
    
    
    func backspace () -> Double? {
        if !opStack.isEmpty{
        opStack.removeLast()
        }
    return evaluate()
    }
    
    var variableValues = [String:Double]()
  
    func clearDisplay() -> Double? {
        opStack.removeAll()
        variableValues = [String:Double]()
        return evaluate()
    }
    
//    typealias PropertyList = AnyObject
//
//    var program: PropertyList {//guarantee to be a PropertyList
//        get{
//            return opStack.map{ $0.description}
////            var returnValue = Array<String>()
////            for op in opStack{
////                returnValue.append(op.description)
////            }
////            return returnValue
//        }
//        set{
//            if let opSymbols =  newValue as? Array<String>{
//                var newOpstack = [Op]()
//                for opSymbol in opSymbols {
//                    if let op = knownOps[opSymbol]{
//                        newOpstack.append(op)
//                    }else if let operand = NSNumberFormatter().numberFromString(opSymbol)?.doubleValue{
//                        newOpstack.append(.Operand(operand))
//                    }
//                }
//                opStack = newOpstack
//            }
//    }


   
}
