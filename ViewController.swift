//
//  ViewController.swift
//  ScriptorPreAlpha
//
//  Created by Adrian Garcia on 2/16/19.
//  Copyright © 2019 Adrian Garcia. All rights reserved.
//

import UIKit

struct jsonStruct: Decodable {
    var mainText: String
}

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var scriptorLabel: UILabel!
    
    @IBOutlet weak var updateButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var mainGetButton: UIButton!
    
    @IBAction func mainGetButtonPressed(_ sender: Any) {
        mainGetButton.isHidden = true
        updateButton.isHidden = false
        getJSON()
        
    }
    @IBAction func updateButtonPressed(_ sender: Any) {
        getJSON()
    
    }
    
    
    func getJSON() -> String {
        let theURL = "http://jowerg.td2s.com:8080/getData"
        let connectionURL = NSURL(string: theURL)
        let req = NSURLRequest(url: connectionURL as! URL)
        var array = [String]()
        URLSession.shared.dataTask(with: req as URLRequest){
            (data, response, error) in
            if(error != nil){
                print(error!.localizedDescription)
                return
            }
            
            let dataLocal = data
            
            let decoder = JSONDecoder()
            var output: [jsonStruct]?
            
            do{
                output = try? decoder.decode([jsonStruct].self, from: dataLocal!)
            }
            var toPrint: String = ""
            for structure in output!{
                
                array.append(structure.mainText)
                toPrint = "\(toPrint)\(structure.mainText)\n"
                
            }
            
            print(toPrint)
            DispatchQueue.main.async(execute: {
                self.displayLabel.text = toPrint
            })
            }.resume()
        return theURL
    }
}

