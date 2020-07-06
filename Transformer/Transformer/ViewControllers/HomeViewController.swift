//
//  ViewController.swift
//  Transformer
//
//  Created by Hoang Tran on 2020-07-02.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController  {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var transformers : [TransformerObject]?
    fileprivate var autoBots : [TransformerObject]? = [TransformerObject]()
    fileprivate var deceptions : [TransformerObject]? = [TransformerObject]()
    fileprivate let cellIdentity = "TransformerTableCell"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setupLogic()
        
    }
    
    
}


///////////////////////////////////////////////////////////////
//MARK: - Action
///////////////////////////////////////////////////////////////
extension HomeViewController {
    @IBAction func fightButtonClicked(_ sender: Any) {
        let status = TransformerObject.battle(firstGroup: self.autoBots!, secondGroup: self.deceptions!)
        let fightingViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FightingViewController") as! FightingViewController
        fightingViewController.battleStatus = status.0
        self.present(fightingViewController, animated: true, completion: nil)
    }
}

///////////////////////////////////////////////////////////////
//MARK: - Layout
///////////////////////////////////////////////////////////////
extension HomeViewController
{
    fileprivate func setupLayout() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}


///////////////////////////////////////////////////////////////
//MARK: - Logic
///////////////////////////////////////////////////////////////
extension HomeViewController
{
    /*
    * Function: if token isn't exist, there's no item before, otherwise, the app will get the items from API
    * @param:
    * @return:
    */
    fileprivate func setupLogic() {
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
}


///////////////////////////////////////////////////////////////
//MARK: - API
///////////////////////////////////////////////////////////////
extension HomeViewController
{
    func updateTransformerArrays(){
        self.autoBots?.removeAll()
        self.deceptions?.removeAll()
        
        for item in self.transformers! {
            if item.team == "A"
            {
                self.autoBots?.append(item)
            }else{
                self.deceptions?.append(item)
            }
        }
                
        self.autoBots = TransformerObject.sortedByRank(transformers: self.autoBots!)
        self.deceptions = TransformerObject.sortedByRank(transformers: self.deceptions!)

    }
    
    func getTransformers()
    {
        retrieveTransformers { (error, transformers) in
            
            if error == nil{
                
                self.transformers = transformers
                self.updateTransformerArrays()
                self.tableView.reloadData()
                
            }else{
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Got it", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                
            }

        }
    }
}

extension HomeViewController : AddTransformerViewControllerDelegate{
    func didUpdate(transformer: TransformerObject) {
        
        for item in self.transformers! {
            if item.id == transformer.id {
                item.updateValue(transformer)
            }
        }
        
        self.updateTransformerArrays()
        
        tableView.reloadData()
    }
}


///////////////////////////////////////////////////////////////
//MARK: - TableCell delegate
///////////////////////////////////////////////////////////////
extension HomeViewController : TransformerTableCellDelegate{
    func didSelectEditButton(_ indexPath: IndexPath) {
        let addTransformerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddTransformerViewController") as! AddTransformerViewController
        let arrayTransformer = (indexPath.section == 0) ? self.autoBots : self.deceptions
        let transformer = arrayTransformer![indexPath.row]
        addTransformerViewController.delegate = self
        
        self.present(addTransformerViewController, animated: true, completion: nil)
        addTransformerViewController.setupWithTransformer(transformer)
        addTransformerViewController.type = .edit
        addTransformerViewController.delegate = self
    }
}



///////////////////////////////////////////////////////////////
//MARK: - TableView Delegate and Datasource.
//Section 0 is autobot and section 1 is deception
///////////////////////////////////////////////////////////////

extension HomeViewController : UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.autoBots?.count ?? 0
        }
        return self.deceptions?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let arrayTransformer = (indexPath.section == 0) ? self.autoBots : self.deceptions
        let transformer = arrayTransformer![indexPath.row]
        
        let cell:TransformerTableCell = tableView.dequeueReusableCell(withIdentifier: cellIdentity, for: indexPath) as! TransformerTableCell
        cell.currentIndexPath = indexPath
        cell.delegate = self
        cell.nameLabel.text = transformer.name
        let text = "\(transformer.strength!) \(transformer.intelligence!) \(transformer.rank!)"
        cell.valuesLabel.text = text
        cell.avatarImage.sd_setImage(with: URL(string: transformer.team_icon!), placeholderImage: nil)

        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let transformer = self.transformers![indexPath.row]
            deleteTransformer(transformerID: transformer.id!) { (error, success) in
                if success == true{
                    self.transformers?.removeAll(where: { (item) -> Bool in
                        if item.id == transformer.id{
                            return true
                        }else{
                            return false
                        }
                    })
                    if indexPath.section == 0 {
                        self.autoBots?.remove(at: indexPath.row)
                    }else{
                        self.deceptions?.remove(at: indexPath.row)
                    }
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                    
                }else{
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Got it", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TransformerTableCell.CELL_HEIGHT
    }
    
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String? {
       switch(section) {
            case 0: return "Autobot"
            case 1: return "Deception"
            default: return ""

       }
    }

}

