//
//  ViewController.swift
//  Transformer
//
//  Created by Hoang Tran on 2020-07-02.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if KeychainManager.shareInstance.getString(keyString: Constants.kToken) == ""{
            retrieveToken { (error, token) in
                if error != nil || token == nil{
                    print(error.debugDescription)
                }else{
                    KeychainManager.shareInstance.saveToKeychain(savedString: token!,keyString:Constants.kToken)
                }
            }
        }else{
                getTransformers()
        }
    }
    
    func addTransformer()
    {

        let newTransformer = TransformerObject()
        newTransformer.name = "Hoang"
        newTransformer.strength = 10
        newTransformer.intelligence = 10
        newTransformer.speed = 5
        newTransformer.endurance = 6
        newTransformer.rank = 9
        newTransformer.courage = 5
        newTransformer.firepower = 6
        newTransformer.skill  = 10
        newTransformer.team = "D"
        
        createATransformer(transformer: newTransformer) { (error, addedTransformer) in
            print("abc")
        }
    }

    func getTransformers()
    {
        retrieveTransformers { (error, transformers) in
            print("abc")
        }
    }

}

