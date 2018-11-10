//
//  ViewController.swift
//  NextSettingsBundle
//
//  Created by Valmir Junior on 10/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

enum UDKeys {
    static let color = "color"
    static let autoPlay = "autoPlay"
    static let name = "name"
}

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var autoPlaySwitch: UISwitch!
    @IBOutlet weak var colorSegmentedControl: UISegmentedControl!
    
    
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameTextField.text = ud.string(forKey: UDKeys.name)
        autoPlaySwitch.setOn(ud.bool(forKey: UDKeys.autoPlay), animated: false)
        colorSegmentedControl.selectedSegmentIndex = ud.integer(forKey: UDKeys.color)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        ud.set(nameTextField.text, forKey: UDKeys.name)
    }
    
    @IBAction func changeAutoplay(_ sender: UISwitch) {
        ud.set(sender.isOn, forKey: UDKeys.autoPlay)
    }
    
    @IBAction func changeColor(_ sender: UISegmentedControl) {
        ud.set(sender.selectedSegmentIndex, forKey: UDKeys.color)
    }
    

}

