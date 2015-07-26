###Notes for class

####1st class
1. basic concept in iOS design
2. basic swift programming
3. exclaimation point "!": to unwrap the optional valye

This is my work:

![](http://m2.img.srcdd.com/farm4/d/2015/0726/12/57DF5BE70A16E9AB10D60D9CAB87435C_ORIG_371_665.gif)

####2nd class
1. MVC: Model-View-Controller
2. ` @IBOutlet weak var display: UILabel!`:'!' is meant " an optional but always automatically unwrapped".
3. Auto layout
4. function of calculating:
5. ```swift   @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
             case "×":  performOperation(multiply)
             case "÷":  performOperation(divide)
             case "+":  performOperation(multiply)
             case "−":  performOperation(multiply)
            default: break
        }
    }
    
    func performOperation( operation:(Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast() , operandStack.removeLast())
            enter()
        }
    }
    func multiply(op1:Double, op2: Double) -> Double{
        return op1 * op2
    }
 ```
 the more concise one:
 
 ```swift
     @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
             case "×":  performOperation { $0 * $1 }
             case "÷":  performOperation { $1 / $0 }
             case "+":  performOperation { $0 + $1 }
             case "−":  performOperation { $0 - $1 }
            default: break
        }
    }
    
    func performOperation( operation:(Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast() , operandStack.removeLast())
            enter()
        }
    }
    ```
    
 
![](http://m2.img.srcdd.com/farm4/d/2015/0726/12/BC698AC5D04F0019DB471C02B9D1231E_ORIG_657_665.gif)
