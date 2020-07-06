//
//  AddTransformerViewController.swift
//  Transformer
//
//  Created by Hoang Tran on 2020-07-04.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit


enum Type {
    case add
    case edit
}



protocol AddTransformerViewControllerDelegate:class {
    func didUpdate(transformer:TransformerObject) -> Void
}


class AddTransformerViewController: UIViewController {
    
    ///////////////////////////////////////////////////////////////
    //MARK: - Properties
    ///////////////////////////////////////////////////////////////
    weak var delegate:AddTransformerViewControllerDelegate?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var strengthButton: UIButton!
    @IBOutlet weak var intelligenceButton: UIButton!
    @IBOutlet weak var teamButton: UIButton!
    @IBOutlet weak var skillsButton: UIButton!
    @IBOutlet weak var firePowerButton: UIButton!
    @IBOutlet weak var courageButton: UIButton!
    @IBOutlet weak var rankButton: UIButton!
    @IBOutlet weak var enduranceButton: UIButton!
    @IBOutlet weak var speedButton: UIButton!
    @IBOutlet weak var addTransformerButton: UIButton!
    
    var transfomer : TransformerObject? = TransformerObject()
    var type : Type = .add
        
    ///////////////////////////////////////////////////////////////
    //MARK: - Life cycle
    ///////////////////////////////////////////////////////////////
    override func viewDidLoad() {
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.type == .add{
            self.addTransformerButton.setTitle("Add Transformer", for: .normal)
        }else{
            self.addTransformerButton.setTitle("Update Transformer", for: .normal)
        }
        
    }
}


///////////////////////////////////////////////////////////////
//MARK: - Actions
///////////////////////////////////////////////////////////////
extension AddTransformerViewController {
    
    
    @IBAction func StrengthClicked(_ sender: Any) {
        showNumberActionSheet(sender as! UIButton)
    }
    
    @IBAction func intelligenceClicked(_ sender: Any) {
        showNumberActionSheet(sender as! UIButton)
    }
    
    @IBAction func speedClicked(_ sender: Any) {
        showNumberActionSheet(sender as! UIButton)
    }
    
    @IBAction func enduranceClicked(_ sender: Any) {
        showNumberActionSheet(sender as! UIButton)
    }
    
    @IBAction func rankClicked(_ sender: Any) {
        showNumberActionSheet(sender as! UIButton)
    }
    
    @IBAction func courageClicked(_ sender: Any) {
        showNumberActionSheet(sender as! UIButton)
    }
    
    @IBAction func firePowerClicked(_ sender: Any) {
        showNumberActionSheet(sender as! UIButton)
    }
    
    @IBAction func skillsClicked(_ sender: Any) {
        showNumberActionSheet(sender as! UIButton)
    }
    
    @IBAction func teamClicked(_ sender: Any) {
        showTeamActionSheet(sender as! UIButton)
    }
        
    @IBAction func addTransformerClick(_ sender: Any) {
        self.transfomer?.name = self.nameTextField.text
        
        let message = validate()
        if message.count != 0{
            
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        }else{
            if self.type == .add{
                addTransformer()
            }else{
                updateTransformer()
            }
        }
    }
}



///////////////////////////////////////////////////////////////
//MARK: - Logic
///////////////////////////////////////////////////////////////
extension AddTransformerViewController{
    fileprivate func updateTransformer(){
        self.transfomer?.team_icon = nil
        updateTransformers(transformer: self.transfomer!) { (error, returnedTransformer) in
            if error == nil{
                let alert = UIAlertController(title: "Success", message: "The transformer is update!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Got it", style: .cancel, handler: { (alertViewController) in
                    
                    self.transfomer?.updateValue(returnedTransformer!)
                    self.delegate?.didUpdate(transformer: self.transfomer!)
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true)
            }else{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Got it", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    fileprivate func addTransformer(){
        createATransformer(transformer: self.transfomer!) { (error, returnedTransformer) in
            if error == nil{
                let alert = UIAlertController(title: "Success", message: "The transformer is created!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Got it", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                self.resetValue()
            }else{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Got it", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    fileprivate func showNumberActionSheet(_ sender : UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for i in 1...10{
            alert.addAction(UIAlertAction(title: "\(i)", style: .default , handler:{ (UIAlertAction)in
                
                switch sender{
                case self.strengthButton: self.transfomer?.strength = i; break;
                case self.intelligenceButton: self.transfomer?.intelligence = i; break;
                case self.speedButton: self.transfomer?.speed = i; break;
                case self.enduranceButton: self.transfomer?.endurance = i; break;
                case self.rankButton: self.transfomer?.rank = i; break;
                case self.courageButton: self.transfomer?.courage = i; break;
                case self.firePowerButton: self.transfomer?.firepower = i; break;
                case self.skillsButton: self.transfomer?.skill = i; break;
                default:
                    break
                }
                
                sender.setTitle("\(i)", for: .normal)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    /*
    * Function: Show option for choose team function
    * @param:
    * @return:
    */
    fileprivate func showTeamActionSheet(_ sender : UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Autobot", style: .default , handler:{ (UIAlertAction)in
            self.transfomer?.team = "A"
            sender.setTitle("Autobot", for: .normal)
        }))
        
        alert.addAction(UIAlertAction(title: "Deception", style: .default , handler:{ (UIAlertAction)in
            self.transfomer?.team = "D"
            sender.setTitle("Deception", for: .normal)
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    /*
    * Function: Reset the page status
    * @param:
    * @return:
    */
    fileprivate func resetValue(){
        self.transfomer = nil
        self.transfomer = TransformerObject()
        
        setupWithTransformer(self.transfomer!)
    }
    
    /*
    * Function: validate the current transformer
    * @param:
    * @return:
    */
    fileprivate func validate() -> String{
        
        var message = ""
        
        if self.transfomer?.name == nil || self.transfomer?.name == ""{
            message += "Name, "
        }
        
        if self.transfomer?.strength == nil{
            message += "Strength, "
        }
        
        if self.transfomer?.intelligence == nil{
            message += "Intelligence, "
        }
        
        if self.transfomer?.speed == nil{
            message += "Speed, "
        }
        
        if self.transfomer?.endurance == nil{
            message += "Endurance, "
        }
        
        if self.transfomer?.rank == nil{
            message += "Rank, "
        }
        
        if self.transfomer?.courage == nil{
            message += "Courage, "
        }
        
        if self.transfomer?.firepower == nil{
            message += "Firepower, "
        }
        
        if self.transfomer?.skill == nil{
            message += "Skill, "
        }
        
        if self.transfomer?.team == nil{
            message += "Team, "
        }
        
        if message.count != 0{
            message += "can not be empty, please fill them."
        }
        return message
    }
    
    /*
    * Function:Change the page accordingly the transformer
    * @param:
    * @return:
    */
    func setupWithTransformer(_ currentTransformer: TransformerObject){
        self.transfomer = currentTransformer
        
        self.nameTextField.text = self.transfomer?.name
        
        if self.transfomer?.strength != nil{
            self.strengthButton.setTitle("\(self.transfomer!.strength!)", for: .normal)
        }else{
            self.strengthButton.setTitle("Select Strength", for: .normal)
        }
        
        if self.transfomer?.intelligence != nil{
            self.intelligenceButton.setTitle("\(self.transfomer!.intelligence!)", for: .normal)
        }else{
            self.intelligenceButton.setTitle("Select Intelligence", for: .normal)
        }
        
        if self.transfomer?.speed != nil{
            self.speedButton.setTitle("\(self.transfomer!.speed!)", for: .normal)
        }else{
            self.speedButton.setTitle("Select Speed", for: .normal)
        }
        
        if self.transfomer?.endurance != nil{
            self.enduranceButton.setTitle("\(self.transfomer!.endurance!)", for: .normal)
        }else{
            self.enduranceButton.setTitle("Select Endurance", for: .normal)
        }
        
        if self.transfomer?.rank != nil{
            self.rankButton.setTitle("\(self.transfomer!.rank!)", for: .normal)
        }else{
            self.rankButton.setTitle("Select Rank", for: .normal)
        }
        
        if self.transfomer?.courage != nil{
            self.courageButton.setTitle("\(self.transfomer!.courage!)", for: .normal)
        }else{
            self.courageButton.setTitle("Select Courage", for: .normal)
        }
        
        if self.transfomer?.firepower != nil{
            self.firePowerButton.setTitle("\(self.transfomer!.firepower!)", for: .normal)
        }else{
            self.firePowerButton.setTitle("Select Firepower", for: .normal)
        }
        if self.transfomer?.skill != nil{
            self.skillsButton.setTitle("\(self.transfomer!.skill!)", for: .normal)
        }else{
            self.skillsButton.setTitle("Select Skills", for: .normal)
        }
        if self.transfomer?.team != nil{
            if self.transfomer?.team == "A"
            {
                self.teamButton.setTitle("Autobot", for: .normal)
            }else{
                self.teamButton.setTitle("Deception", for: .normal)
            }
        }else{
            self.teamButton.setTitle("Select Team", for: .normal)
        }
        
    }
    
}
