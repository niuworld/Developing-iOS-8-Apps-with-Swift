```swift
class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userInTheMiddleOfTypingNumber: Bool = false
    
    @IBAction func operation(sender: UIButton) {
        let digit = sender.currentTitle!
        if userInTheMiddleOfTypingNumber {
        display.text = display.text! + digit
        }
        else {
            display.text = digit
            userInTheMiddleOfTypingNumber = true
        }
    }
    
    var operandStack: Array<Double> = Array<Double>()
 
    
    @IBAction func enter() {
        userInTheMiddleOfTypingNumber = false
        operandStack.append(displayValue)
        print("operandStack\(operandStack)")
        
    }
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userInTheMiddleOfTypingNumber = false
        }
    }
    
    
    
    @IBAction func operateDigit(sender: UIButton) {
        let operate = sender.currentTitle!
        switch operate{
            case "×": performOperation{ $0 * $1 }
            case "−": performOperation{ $1 - $0 }
            case "+": performOperation{ $0 + $1 }
            case "÷": performOperation{ $1 / $0 }
            case "√": performOperation1{ sqrt($0) }
        default: break
        }
    }
    
    func performOperation(operate:(Double, Double) -> Double){
        if operandStack.count >= 2{
            displayValue = operate(operandStack.removeLast(), operandStack.removeLast() )
            enter()
        }
    }

    func performOperation1(operate: Double -> Double){
        if operandStack.count >= 1{
            displayValue = operate(operandStack.removeLast() )
            enter()
        }
    }


}
```