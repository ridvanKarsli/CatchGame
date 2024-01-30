//
//  ScoreListVC.swift
//  CatchGameDeveloped
//
//  Created by Rıdvan KARSLI on 30.01.2024.
//

import UIKit
import CoreData

class ScoreListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var tableVİew: UITableView!
    
    var scoreArray = [Int]()
    var nameArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableVİew.dataSource = self
        tableVİew.delegate = self
        
        getData()
    }
    
    func getData(){
        scoreArray.removeAll()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameScore")
        
        do{
            let results = try context.fetch(fetchRequest)
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    if let score = result.value(forKey: "score") as? Int{
                        self.scoreArray.append(score)
                    }
                    if let name = result.value(forKey: "name") as? String{
                        self.nameArray.append(name)
                    }
                }
            }
        }catch{
            print("error")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //that is a problem
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    

}
