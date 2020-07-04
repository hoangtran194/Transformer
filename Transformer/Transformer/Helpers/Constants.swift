//
//  Constant.swift
//  Transformer
//
//  Created by Hoang Tran on 2020-07-02.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit

class Constants: NSObject {
    ///////////////////////////////////////////////////////////////
    //MARK: - API
    ///////////////////////////////////////////////////////////////
    static let baseUrl = "https://transformers-api.firebaseapp.com/"    
    static let tokenAPI = baseUrl + "allspark"
    static let crudTransformerAPI = baseUrl + "transformers"
    
    
    ///////////////////////////////////////////////////////////////
    //MARK: - Others
    ///////////////////////////////////////////////////////////////
    static let emptyValue = ""
    static let kToken = "kToken"
}
