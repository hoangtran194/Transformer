//
//  FightingViewController.swift
//  Transformer
//
//  Created by Hoang Tran on 2020-07-05.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit
import SDWebImage
import AVFoundation

class FightingViewController: UIViewController {
    
    ///////////////////////////////////////////////////////////////
    //MARK: - Properties
    ///////////////////////////////////////////////////////////////
    var player : AVAudioPlayer = AVAudioPlayer()
    var battleStatus : BattleStatus = .SpecialCase
    @IBOutlet weak var fightingLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fightingLabelYConstraint: NSLayoutConstraint!
    
    
    let fightingString      = "Fighting"
    let autobotAttack       = "AutoBotAttack"
    let deceptionAttack     = "DeceptionAttack"
    
    let gifType             = "gif"
    let autobotWinSound     = "AutobotWinSound"
    let autobotWinImage     = "AutoBotWin"
    
    let deceptionWinSound   = "DeceptionWinSound"
    let deceptionWinImage   = "DeceptionWin"
    let specialImage        = "Special"
    
    let tieImage            = "Tie"    
    let mp3Type             = "mp3"
    
    ///////////////////////////////////////////////////////////////
    //MARK: - Life cycle
    ///////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fightingLabel.alpha = 0.0
        self.fightingLabel.text = "Fighting"
        fightingLabelYConstraint.constant = 0
        showAutoBotImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.player.stop()
    }
    
}


///////////////////////////////////////////////////////////////
//MARK: - Logic
///////////////////////////////////////////////////////////////
extension FightingViewController {
    func showAutoBotImage()
    {
        imageView.sd_setImage(with: Bundle.main.url(forResource: autobotAttack, withExtension: gifType), completed: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.showDeceptionImage()
        }
    }
    
    func showDeceptionImage(){
        imageView.sd_setImage(with: Bundle.main.url(forResource: deceptionAttack, withExtension: gifType), completed: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.showFightingText()
        }
    }
    
    func showFightingText(){
        fightingLabel.alpha = 0
        UIView.animate(withDuration: 0.6,
                       animations: {
                        self.fightingLabel.alpha = 1.0
                        self.fightingLabel.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                        
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.6) {
                            self.fightingLabel.transform = CGAffineTransform.identity
                            self.fightingLabel.alpha = 0.0
                            self.showFightingScence()
                        }
        })
    }
    
    func showFightingScence(){
        
        imageView.sd_setImage(with: Bundle.main.url(forResource: fightingString, withExtension: gifType), completed: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 15.0) {
            self.showBattleResult()
        }
    }
    
    func showBattleResult(){
                
        self.fightingLabel.alpha = 1.0
        fightingLabelYConstraint.constant = 150
        
        if self.battleStatus == .Win{
            self.fightingLabel.text = "Win!"
            self.play(url: Bundle.main.url(forResource: autobotWinSound, withExtension: mp3Type)!)
            imageView.image = UIImage(named: autobotWinImage)
        }else if self.battleStatus == .Lose{
            self.fightingLabel.text = "Win!"
            self.play(url: Bundle.main.url(forResource: deceptionWinSound, withExtension: mp3Type)!)
            imageView.image = UIImage(named: deceptionWinImage)
        }else if self.battleStatus == .Tie{
            self.fightingLabel.text = "Tie!"
            imageView.image = UIImage(named: tieImage)
        }else{
            self.fightingLabel.text = "No one lives!"
            imageView.image = UIImage(named: specialImage)
        }
    }
}


///////////////////////////////////////////////////////////////
//MARK: - Utilities
///////////////////////////////////////////////////////////////
extension FightingViewController{
    func play(url:URL) {
        do {
            self.player = try AVAudioPlayer(contentsOf: url as URL)
            player.prepareToPlay()
            player.volume = 1.0
            player.numberOfLoops = -1
            player.play()
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
}
