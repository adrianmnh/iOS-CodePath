//
//  ViewController.swift
//  Prework
//
//  Created by MacBook Pro on 8/1/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var stepper: UIStepper!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet var stepperLabel: UILabel!
    @IBOutlet var split1: UILabel!
    @IBOutlet var split2: UILabel!
    @IBOutlet var tipPerPerson: UILabel!
    @IBOutlet var totalPerPerson: UILabel!
    var tipPercentages = [15.0, 18.0, 20.0]
    var darkMode : Bool = false
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Did Load")
        
    }
    

    
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        
        
        
        print(darkMode)
        
        
        print(tipPercentages)
        
        //let defaults = UserDefaults.standard
        
        stepper.value = defaults.double(forKey: "stepper")
        
        darkMode = defaults.bool(forKey: "mode")
        
        print(darkMode)
        
        colorMode(mode: darkMode)
        
        
        
        //let myDouble = defaults.double(forKey: "tip1")
        for i in 0...2{
            tipPercentages[i] = defaults.double(forKey: String(format: "tip\(i+1)"))
            tipControl.setTitle(String(format:"%.0f%%",tipPercentages[i]), forSegmentAt: i)
        }
        print("saved")
        
        billAmountTextField.becomeFirstResponder()
        
        calculate()
        calculateSplit(num: stepper.value)
        
    


    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        
        
        
        print(tipPercentages)
              
        

        

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did disappear")
    }
    
    func colorMode(mode: Bool){
        if(mode){
            view.overrideUserInterfaceStyle = .dark
            navigationController?.overrideUserInterfaceStyle = .dark
        }
        else{
            view.overrideUserInterfaceStyle = .light
            navigationController?.overrideUserInterfaceStyle = .light
        }
    }
    
    
    func calculate(){
        let bill = Double(billAmountTextField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]/100
        let total = bill + tip
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        calculate()
        calculateSplit(num:stepper.value)
    }
    @IBAction func calculateInput(_ sender: Any) {
        calculate()
        calculateSplit(num:stepper.value)
    }
    
    
    @IBAction func splitBill(_ sender: Any) {
        
        let x = Double(stepper.value)
        
        defaults.set(x, forKey: "stepper")
        calculateSplit(num : x)
        
        if(x > 1){
            stepperLabel.text = String(format: "split %.f ways",stepper.value)
        }
        else{
            stepperLabel.text = String(format: "%.f",stepper.value)
        }
        

        
    }
    
    func calculateSplit(num: Double){
        let bill = Double(billAmountTextField.text!) ?? 0
        if(num <= 1 || bill == 0){
            split1.text = ""
            split2.text = ""
            totalPerPerson.text = ""
            tipPerPerson.text = ""
//            stepperLabel.text = "\(num)"
            stepperLabel.text = String(format: "%.f",stepper.value)
        }
        
        else{
            //if(bill > 0){
                stepperLabel.text = String(format: "split %.f ways",stepper.value)
                split1.text = "Tip "
                split2.text = "Total "
                
                let tip = (bill * tipPercentages[tipControl.selectedSegmentIndex]/100)/num
                let total = bill/num + tip
                tipPerPerson.text = String(format: "$%.2f", tip)
                totalPerPerson.text = String(format: "$%.2f each", total)
            //}
        }        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSettings"{
            let destinationController = segue.destination as! SettingsViewController
            
            destinationController.labelText = billAmountTextField.text!
            
            destinationController.customTip1 = totalLabel.text!
            destinationController.tipArray = tipPercentages
            destinationController.stepper = stepper.value
            
        }
    }
    
    
    
}
