//
//  SettingsViewController.swift
//  SettingsViewController
//
//  Created by MacBook Pro on 8/3/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var switchMode: UISwitch!
    @IBOutlet var customTipLabel1: UILabel!
    @IBOutlet var customTipLabel2: UILabel!
    @IBOutlet var customTipLabel3: UILabel!
    @IBOutlet var customTipTextbox1: UITextField!
    @IBOutlet var customTipTextbox2: UITextField!
    @IBOutlet var customTipTextbox3: UITextField!
    
    var mode : Bool = false
    var labelText = String()
    var customTip1 = String()
    var tipArray : [Double] = []
    var stepper = Double()
    let defaults = UserDefaults.standard
    
    
    var data = ""
    
    func loadDefaults(){
        let defaults = UserDefaults.standard
//        defaults.set(tipPercentages[0], forKey: "tip1")
//        defaults.set(tipPercentages[1], forKey: "tip2")
//        defaults.set(tipPercentages[2], forKey: "tip3")       
        
//        defaults.set(tipArray, forKey: "tips")        
////        defaults.set(tipArray[0], forKey: "tip1")
////        defaults.set(tipArray[1], forKey: "tip2")
////        defaults.set(tipArray[2], forKey: "tip3")
//        defaults.synchronize()
        
        
        
        let arr : [UILabel] = [customTipLabel1, customTipLabel2, customTipLabel3]
        for i in 0...2{
            arr[i].text = String(format: "%.f%%", defaults.double(forKey: String(format:"tip\(i+1)")))
        }
        
        if(defaults.bool(forKey: "mode") == true){
            switchMode.isOn = true
        }
        
//        customTipLabel1.text = String(format: "%.f%%", defaults.double(forKey: "tip1"))
//        customTipLabel2.text = String(format: "%.f%%", defaults.double(forKey: "tip2"))
//        customTipLabel3.text = String(format: "%.f%%", defaults.double(forKey: "tip3"))
        
    }
    
    @IBAction func restoreDefaults(_ sender: Any) {
        changeCustomTip(num: 0, tipValue: 15)
        changeCustomTip(num: 1, tipValue: 18)
        changeCustomTip(num: 2, tipValue: 20)
        loadDefaults()
        defaults.set(1, forKey: "stepper")
    }
    
    
    @IBAction func switchMode(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        
        if switchMode.isOn{
            mode = true
            print("is \(mode)")
//            view.backgroundColor = .black
//            navigationController?.navigationBar.backgroundColor = .black
            view.overrideUserInterfaceStyle = .dark
            //navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
                       
        }
        else{
            mode = false
            print("is \(mode)")
//            view.backgroundColor = .white
//            navigationController?.navigationBar.backgroundColor = .white
            view.overrideUserInterfaceStyle = .light
            navigationController?.navigationBar.overrideUserInterfaceStyle = .light
            
        }
        defaults.set(mode, forKey: "mode")
        defaults.synchronize()
     
    }
    
    func changeCustomTip(num: Int, tipValue: Double){
        let defaults = UserDefaults.standard
        tipArray[num] = tipValue
        defaults.set(tipArray[num], forKey: String(format:"tip\(num+1)"))
        defaults.synchronize()
    }
    
    
    @IBAction func changeCustomTip1(_ sender: Any) {
        changeCustomTip(num: 0, tipValue: Double(customTipTextbox1.text!) ?? 0)
    }
    @IBAction func changeCustomTip2(_ sender: Any) {
        changeCustomTip(num: 1, tipValue: Double(customTipTextbox2.text!) ?? 0)
    }
    @IBAction func changeCustomTip3(_ sender: Any) {
        changeCustomTip(num: 2, tipValue: Double(customTipTextbox3.text!) ?? 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //label1.text = labelText
//        customTipTextbox1.text = String(format: "%.f", tipArray[0]*100)
//        customTipTextbox2.text = String(format: "%.f", tipArray[1]*100)
//        customTipTextbox3.text = String(format: "%.f", tipArray[2]*100)
        //customTipTextbox1.text = String(format: "%.f", defaults.double(forKey: tip1))
        //let value = UserDefaults.value(forKey: "tip1")
        //print(value!)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! MainViewController
        destinationController.tipPercentages = tipArray
        destinationController.darkMode = mode
        destinationController.stepper.value = stepper
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        loadDefaults()
        customTipTextbox1.becomeFirstResponder()
        
        
//        let defffs = UserDefaults.standard
//        defffs.set(500.123, forKey: "tip1")
//        defffs.synchronize()
//        let myD = defffs.value(forKey: "tip1")
//        print(myD!)
//        // This is a good place to retrieve the default tip percentage from UserDefaults
//        // and use it to update the tip amount
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)        
        print("view did appear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did disappear")
    }
    

    
    

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
