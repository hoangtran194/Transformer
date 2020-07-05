//
//  TransformerObject.swift
//  Transformer
//
//  Created by Hoang Tran on 2020-07-02.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit

class TransformerObject: NSObject , Codable{
    var id : String?
    var name : String?
    var strength : Int?
    var intelligence : Int?
    var speed : Int?
    var endurance : Int?
    var rank : Int?
    var courage : Int?
    var firepower : Int?
    var skill : Int?
    var team : String?
    var team_icon : String?
    
    
    private enum CodingKeys : String, CodingKey{
        case id
        case name
        case strength
        case intelligence
        case speed
        case endurance
        case rank
        case courage
        case firepower
        case skill
        case team
        case team_icon
    }
    
    func toDictionary()->[String:AnyObject]
    {
        var result : [String: AnyObject] = [String:AnyObject]()
        
        if id != nil {
            result["id"] = id as AnyObject?
        }
        
        if name != nil {
            result["name"] = name as AnyObject?
        }
        
        if strength != nil {
            result["strength"] = strength as AnyObject?
        }
        
        if intelligence != nil {
            result["intelligence"] = intelligence as AnyObject?
        }
        
        if speed != nil {
            result["speed"] = speed as AnyObject?
        }
        
        if endurance != nil {
            result["endurance"] = endurance as AnyObject?
        }
        
        if rank != nil {
            result["rank"] = rank as AnyObject?
        }
        
        if courage != nil {
            result["courage"] = courage as AnyObject?
        }
        
        if firepower != nil {
            result["firepower"] = firepower as AnyObject?
        }
        
        if skill != nil {
            result["skill"] = skill as AnyObject?
        }
        
        if team != nil {
            result["team"] = team as AnyObject?
        }
        
        if team_icon != nil {
            result["team_icon"] = team_icon as AnyObject?
        }
        
        return result
    }
    
    func updateValue(_ transformer: TransformerObject)
    {
        self.id = transformer.id
        self.name = transformer.name
        self.strength = transformer.strength
        self.intelligence = transformer.intelligence
        self.speed = transformer.speed
        self.endurance = transformer.endurance
        self.rank = transformer.rank
        self.courage = transformer.courage
        self.firepower = transformer.firepower
        self.skill = transformer.firepower
        self.team = transformer.team
        self.team_icon = transformer.team_icon        
    }
}
