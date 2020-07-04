//
//  RequestWrappter.swift
//  Transformer
//
//  Created by Hoang Tran on 2020-07-02.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//


import Foundation
import Alamofire

let header = ["Content-Type":"application/json"]

enum NetworkError : Error
{
    case unKnown(String)
}


///////////////////////////////////////////////////////////////
//MARK: - APIs
///////////////////////////////////////////////////////////////

/*
* Function:retrieve transformers
* @param:
* @return:
*/
func retrieveTransformers(completion : @escaping(Error?,[TransformerObject]?) ->())
{
    let endPoint        = Constants.crudTransformerAPI
    let header          = headerWithToken()
    let transformerKey  = "transformers"
    
    AF.request(endPoint,
               method: .get,
               parameters: nil,
               encoding: JSONEncoding.default,
               headers: HTTPHeaders(header))
        .responseString { (response) in
            
            if let error = response.error{
                
                completion(error,nil)
                return
                
            }
            do{
                
                let result = try JSONDecoder().decode([String:[TransformerObject]].self, from: response.data!)
                completion(nil,result[transformerKey])
                
            }catch{
                
                completion( NetworkError.unKnown(response.value ?? ""), nil)
                
            }
    }
}

/*
* Function:delete the transformer
* @param:
* @return:
*/
func deleteTransformer(transformerID: String, completion : @escaping(Error?,Bool) ->())
{
    let endPoint        = Constants.crudTransformerAPI + "/" + transformerID
    let header          = headerWithToken()
    let succeededCode   = 204
    
    AF.request(endPoint,
               method: .delete,
               parameters: nil,
               encoding: URLEncoding.default,
               headers: HTTPHeaders(header))
        .responseString { (response) in
            if let error = response.error{
                completion(error,false)
                return
            }
            
            let result = response.response?.statusCode
            if result == succeededCode {
                completion(nil, true)
            }else{
                completion(nil, false)
            }
    }
}

/*
* Function: update the transformer
* @param:
* @return:
*/
func updateTransformers(transformer: TransformerObject, completion : @escaping(Error?,TransformerObject?) ->())
{
    
    let endPoint        = Constants.crudTransformerAPI
    let header          = headerWithToken()
    
    AF.request(endPoint,
               method: .put,
               parameters: nil,
               encoding: URLEncoding.default,
               headers: HTTPHeaders(header))
        .responseString { (response) in
            if let error = response.error{
                completion(error,nil)
                return
            }
            do{
                
                let result = try JSONDecoder().decode(TransformerObject.self, from: response.data!)
                completion(nil,result)
                
            }catch{
                
                print(response.value!)
                completion( NetworkError.unKnown(response.value ?? Constants.emptyValue),nil)
                
            }
    }
}

/*
* Function:Create a new transformer
* @param:
* @return:
*/
func createATransformer(transformer: TransformerObject, completion : @escaping(Error?,TransformerObject?) ->())
{
    let endPoint = Constants.crudTransformerAPI
    let header = headerWithToken()
    
    
    let parameters = transformer.toDictionary()
    
    AF.request(endPoint,
               method: .post,
               parameters: parameters,
               encoding: JSONEncoding.default,
               headers: HTTPHeaders(header))
        .responseString { (response) in
            if let error = response.error{
                completion(error,nil)
                return
            }
            do{
                
                let result = try JSONDecoder().decode(TransformerObject.self, from: response.data!)
                completion(nil,result)
                
            }catch{
                
                print(response.value!)
                completion( NetworkError.unKnown(response.value ?? Constants.emptyValue),nil)
                
            }
    }
    
}


/*
* Function:Get the token
* @param:
* @return:
*/
func retrieveToken(completion : @escaping(Error?,String?) ->())
{
    let endPoint = Constants.tokenAPI
    AF.request(endPoint,
               method: .get,
               parameters: nil,
               encoding: URLEncoding.default,
               headers: nil)
        .responseString { (response) in
            
            if let error = response.error{
                
                completion(error,nil)
                return
                
            }
            
            completion(nil, response.value)
    }
}


/*
 * Function: Craete the header with Token inside
 * @param:
 * @return:
 */
fileprivate func headerWithToken()->[String:String]
{
    var result = ["Content-Type":"application/json"]
    let token = KeychainManager.shareInstance.getString(keyString: Constants.kToken)
    if token != ""{
        result["Authorization"] = "Bearer " + token
    }
    return result
}
