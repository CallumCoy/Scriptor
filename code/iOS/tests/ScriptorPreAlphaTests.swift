//
//  ScriptorPreAlphaTests.swift
//  ScriptorPreAlphaTests
//
//  Created by Adrian Garcia on 2/16/19.
//  Copyright © 2019 Adrian Garcia. All rights reserved.
//

import XCTest
@testable import ScriptorPreAlpha

func getJSON() -> String {
    let theURL = "http://jowerg.td2s.com:8080/getData"
    let connectionURL = NSURL(string: theURL)
    let req = NSURLRequest(url: connectionURL as! URL)
    var array = [String]()
    var toPrint: String = ""
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
        
        for structure in output!{
            
            array.append(structure.mainText)
            toPrint = "\(toPrint)\(structure.mainText)\n"
            
        }
        
        print(toPrint)
        DispatchQueue.main.async(execute: {
            //self.displayLabel.text = toPrint
        })
        }.resume()
    return toPrint
}

class ScriptorPreAlphaTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testConnection() {
        XCTAssertTrue(getJSON() != nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
