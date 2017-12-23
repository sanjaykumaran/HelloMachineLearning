//
//  ViewController.swift
//  GoMachineLearning
//
//  Created by Sanjay Kumaran on 23/12/17.
//  Copyright © 2017 Sanjay Kumaran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var genderLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.delegate = self
        
    }
    
    // string="nina"
    /*  "firstLetter1=n"    :1.0    */
    /*  "firstLetter2=i"    :1.0    */
    /*  "firstLetter3=n"    :1.0    */
    /*  "lastLetter1=i"     :1.0    */
    /*  "lastLetter2=n"     :1.0   */
    /*  "lastLetter3=a"     :1.0    */
    
    func features (_ string:String) -> [String:Double] {
        guard !string.isEmpty else {return [:]}
        
        let string = string.lowercased()
        var keys = [String]()
        
        keys.append("firstLetter1=\(string.prefix(1))")
        keys.append("firstLetter2=\(string.prefix(2))")
        keys.append("firstLetter3=\(string.prefix(3))")
        keys.append("lastLetter1=\(string.suffix(1))")
        keys.append("lastLetter2=\(string.suffix(2))")
        keys.append("lastLetter3=\(string.suffix(3))")
        
        return keys.reduce([String: Double]()) { (result, key) -> [String: Double] in
            var result = result
            result[key] = 1.0
            
            return result
        }
        
    }
    
    func predictGenderFromName (_ name:String) -> String? {
        let nameFeatures = features(name)
        
        let model = GenderByName()
        
        if let prediction = try? model.prediction(input: nameFeatures) {
            if prediction.classLabel == "F" {
                return "Female"
            }else{
                return "Male"
            }
        }
        
        return nil
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        genderLabel.text = predictGenderFromName(nameLabel.text!)
        
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

