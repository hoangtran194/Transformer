//
//  KeychainManager.swift
//  Transformer
//
//  Created by Hoang Tran on 2020-07-02.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit
import KeychainAccess

class KeychainManager: NSObject {
    
    static let shareInstance        = KeychainManager()
    fileprivate let serviceName     = "com.Aequilibrium.Transformer"
    
    func saveToKeychain(savedString:String, keyString key: String)
    {
        do {
            let keychain = Keychain(service: serviceName)
            try keychain.set(savedString, key: key)
        }
        catch let error {
            print(error)
        }
    }
    
    func getString(keyString key:String) -> String
    {
        do {
            let keychain = Keychain(service: serviceName)
            let result = try keychain.get(key) ?? ""
            return result
        }
        catch let error {
            print(error)
            return ""
        }
    }
    
}


