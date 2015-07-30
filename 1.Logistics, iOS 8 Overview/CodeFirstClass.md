code for the first class

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
@IBAction func enter() {
        userInTheMiddleOfTypingNumber = false
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

```