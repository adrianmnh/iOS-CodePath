//
//  TestViewController.swift
//  Twitter
//
//  Created by Oberon on 9/30/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet var label1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date1 = Date()
        
        label1.text = date1 as? String
        
        

        // Do any additional setup after loading the view.
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
