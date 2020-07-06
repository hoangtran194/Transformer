//
//  TransformerObject.swift
//  Transformer
//
//  Created by Hoang Tran on 2020-07-02.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit


enum BattleStatus {
    case Win
    case Tie
    case Lose
    
    case SpecialCase // The game will end immediately
}

class TransformerObject: NSObject , Codable{
    ///////////////////////////////////////////////////////////////
    //MARK: - Properties
    ///////////////////////////////////////////////////////////////
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
    
    
}


///////////////////////////////////////////////////////////////
//MARK: - Functions
///////////////////////////////////////////////////////////////
extension TransformerObject {
    
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
    
    /*
     * Function: return whether transformer is equal to another transformer or not
     * If every properties of 1 transformer equal to another transformer except the ID, team, team icon, function will return true, otherwise, return false
     *
     */
    func isEqualToAnotherTransformer(transformer : TransformerObject) -> Bool
    {
        
        
        if self.name == transformer.name &&
            self.strength == transformer.strength &&
            self.intelligence == transformer.intelligence &&
            self.speed == transformer.speed &&
            self.endurance == transformer.endurance &&
            self.rank == transformer.rank &&
            self.courage == transformer.courage &&
            self.firepower == transformer.firepower &&
            self.skill == transformer.firepower{
            return true
        }
        return false
    }
    
    /*
     * Function: return the transformer that wins in a duel
     * Special cases:
     *   ● Any Transformer named Optimus Prime or Predaking wins his fight automatically regardless of any other criteria
     *   ● In the event either of the above face each other (or a duplicate of each other), the game immediately ends with all competitors destroyed
     * Normal Cases:
     *
     *   ○ If any fighter is down 4 or more points of courage and 3 or more points of strength
     *   compared to their opponent, the opponent automatically wins the face-off regardless of
     *   overall rating (opponent has ran away)
     *   ○ Otherwise, if one of the fighters is 3 or more points of skill above their opponent, they win
     *   the fight regardless of overall rating
     *   ○ The winner is the Transformer with the highest overall rating
     *
     */
    func isWinable(_ transformer: TransformerObject) -> BattleStatus{
        
        let specialName1 = "Optimus Prime".lowercased()
        let specialName2 = "Predaking".lowercased()
        
        ///////////////////////////////////////////////////////////////
        // Case: Special
        ///////////////////////////////////////////////////////////////
        if self.isEqualToAnotherTransformer(transformer: transformer){
            return .SpecialCase
        }
        
        if ( self.name?.lowercased() == specialName1 || self.name?.lowercased() == specialName2)
            && ( transformer.name?.lowercased() == specialName1 || transformer.name?.lowercased() == specialName2){
            return .Tie
        }
        
        if self.name?.lowercased() == specialName1 || self.name?.lowercased() == specialName2{
            return .Win
        }else if transformer.name?.lowercased() == specialName1 || transformer.name?.lowercased() == specialName2{
            return .Lose
        }
        
        ///////////////////////////////////////////////////////////////
        // Case: Normal
        ///////////////////////////////////////////////////////////////
        
        if self.courage! - transformer.courage! >= 4 && self.strength! - transformer.strength! >= 3{
            return .Win
        }else if transformer.courage! - self.courage! >= 4 && transformer.strength! - self.strength! >= 3{
            return .Lose
        }
        
        if abs(self.skill! - transformer.skill!) >= 3{
            if self.skill! > transformer.skill!{
                return .Win
            }
            return .Lose
        }
        
        if self.overallRating() - transformer.overallRating() > 0{
            return .Win
        }else if self.overallRating() - transformer.overallRating() < 0{
            return .Lose
        }
        return .Tie
    }
    
    
    
    /*
     * Function: return the overall rating of transforer
     * Rules: overall rating = Strength + Intelligence + Speed + Endurance + Firepower
     */
    func overallRating()->Int{
        return strength! + intelligence! + speed! + endurance! + firepower!
    }
}


///////////////////////////////////////////////////////////////
//MARK: - Static Functions
///////////////////////////////////////////////////////////////
extension TransformerObject{
    static func sortedByRank(transformers : [TransformerObject]) -> [TransformerObject]{
        let result : [TransformerObject] = transformers.sorted { (left, right) -> Bool in
            if left.rank! <= right.rank!{
                return false
            }
            return true
        }
        return result
    }
    
    
    /*
     * Function: return the status of the battle between 2 teams
     *  ● The teams should be sorted by rank and faced off one on one against each other in order to determine a victor, the loser is eliminated
     *  ● In the event of a tie, both Transformers are considered destroyed
     *  ● Any Transformers who don’t have a fight are skipped (i.e. if it’s a team of 2 vs. a team of 1,
     *  there’s only going to be one battle)
     *  ● The team who eliminated the largest number of the opposing team is the winner
     *  @param: 2 groups of transformer
     *  @return:  first parameter the status of battle, second and third are the destroyed bot for first group and second group, respectively.
     */
    static func battle(firstGroup : [TransformerObject], secondGroup : [TransformerObject] ) -> (BattleStatus,Int,Int){
        
        let sortedGroup1 = self.sortedByRank(transformers: firstGroup)
        let sortedGroup2 = self.sortedByRank(transformers: secondGroup)
        
        var destroyByGroup1 = 0
        var destroyByGroup2 = 0
        
        
        //If one group doesn't have any bot but the other has. The other will automatically win
        if sortedGroup1.count > 0 && sortedGroup2.count == 0{
            return (.Win,0,0)
        }else if sortedGroup1.count == 0 && sortedGroup2.count > 0 {
            return (.Lose,0,0)
        }
        
        //Any Transformers who don’t have a fight are skipped (i.e. if it’s a team of 2 vs. a team of 1, there’s only going to be one battle)
        let interationCount = (sortedGroup1.count >= sortedGroup2.count) ? sortedGroup2.count : sortedGroup1.count
        
        for i in 0...interationCount-1{
            let status = sortedGroup1[i].isWinable(sortedGroup2[i])
            
            
            if status == .SpecialCase{
                return (.SpecialCase,sortedGroup2.count,sortedGroup1.count)
            }
                        
            if status == .Win{
                destroyByGroup1 += 1
            }else if status == .Lose{
                destroyByGroup2 += 1
            }else if status == .Tie{
                destroyByGroup1 += 1
                destroyByGroup2 += 1
            }
        }
        
        if destroyByGroup1 == destroyByGroup2 {
            return (.Tie,destroyByGroup1,destroyByGroup2)
        }else if destroyByGroup1 > destroyByGroup2 {
            return (.Win,destroyByGroup1,destroyByGroup2)
        }else{
            return (.Lose,destroyByGroup1,destroyByGroup2)
        }
    }
}
