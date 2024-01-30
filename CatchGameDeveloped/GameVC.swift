//
//  GameVC.swift
//  CatchGameDeveloped
//
//  Created by Rıdvan KARSLI on 30.01.2024.
//

import UIKit
import CoreData

class GameVC: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var heightScoreLabel: UILabel!
    @IBOutlet weak var nameText: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image9: UIImageView!
    @IBOutlet weak var image10: UIImageView!
    @IBOutlet weak var image11: UIImageView!
    @IBOutlet weak var image12: UIImageView!
    @IBOutlet weak var image13: UIImageView!
    @IBOutlet weak var image14: UIImageView!
    @IBOutlet weak var image15: UIImageView!
    @IBOutlet weak var image16: UIImageView!
    
    var imageArray = [UIImageView]()
    var score = 0
    var heightScore = 0
    var dereceOfDiff = 1.0
    
    var timerCounter : Timer?
    var timerHideImage : Timer?
    var counter = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageArray.append(image1)
        imageArray.append(image2)
        imageArray.append(image3)
        imageArray.append(image4)
        imageArray.append(image5)
        imageArray.append(image6)
        imageArray.append(image7)
        imageArray.append(image8)
        imageArray.append(image9)
        imageArray.append(image10)
        imageArray.append(image11)
        imageArray.append(image12)
        imageArray.append(image13)
        imageArray.append(image14)
        imageArray.append(image15)
        imageArray.append(image16)
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        let gestureRecognizer10 = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        let gestureRecognizer11 = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        let gestureRecognizer12 = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        let gestureRecognizer13 = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        let gestureRecognizer14 = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        let gestureRecognizer15 = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        let gestureRecognizer16 = UITapGestureRecognizer(target: self, action: #selector(tapImage))

        
        image1.addGestureRecognizer(gestureRecognizer1)
        image2.addGestureRecognizer(gestureRecognizer2)
        image3.addGestureRecognizer(gestureRecognizer3)
        image4.addGestureRecognizer(gestureRecognizer4)
        image5.addGestureRecognizer(gestureRecognizer5)
        image6.addGestureRecognizer(gestureRecognizer6)
        image7.addGestureRecognizer(gestureRecognizer7)
        image8.addGestureRecognizer(gestureRecognizer8)
        image9.addGestureRecognizer(gestureRecognizer9)
        image10.addGestureRecognizer(gestureRecognizer10)
        image11.addGestureRecognizer(gestureRecognizer11)
        image12.addGestureRecognizer(gestureRecognizer12)
        image13.addGestureRecognizer(gestureRecognizer13)
        image14.addGestureRecognizer(gestureRecognizer14)
        image15.addGestureRecognizer(gestureRecognizer15)
        image16.addGestureRecognizer(gestureRecognizer16)
        
        
        for image in imageArray{
            image.isUserInteractionEnabled = true
        }
        
        timerCounter = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(Timercounter), userInfo: nil, repeats: true)
        
        timerHideImage = Timer.scheduledTimer(timeInterval: dereceOfDiff, target: self, selector: #selector(hideImage), userInfo: self, repeats: true)
        
        //control heightscore
        let storedHeightScore = UserDefaults.standard.object(forKey: "height_score")
        
        if storedHeightScore == nil {
            heightScore = 0
            heightScoreLabel.text = "Height score : \(heightScore)"
        }
        
        if let newScore = storedHeightScore as? Int{
            heightScore = newScore
            heightScoreLabel.text = "Height score : \(heightScore)"
        }
        
        //userDefaults control
        let storedDerce = UserDefaults.standard.object(forKey: "derece")
        
        if storedDerce == nil{
            dereceOfDiff = 1.0
        }
        if let newDerece = storedDerce as? Double{
            dereceOfDiff = newDerece
        }
        
        getData()
    }

    func getData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameScore")
        
        do{
            let results = try context.fetch(fetchRequest)
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    if let image = result.value(forKey: "image") as? Data{
                        let imageRe = UIImage(data: image as! Data)
                        for image in imageArray{
                            image.image = imageRe
                        }
                    }
                    if let name = result.value(forKey: "name") as? String{
                        nameText.text = "Welcome \(name)"
                    }
                }
            }
        }catch{
            
        }
        
    }
    
    @objc func hideImage(){
        for image in imageArray{
            image.isHidden = true
        }
        let random = arc4random_uniform(UInt32(imageArray.count))
        imageArray[Int(random)].isHidden = false
    }
    
    @objc func tapImage(){
        score = score + 1
        scoreLabel.text = "Score : \(score)"
    }
    
    @objc func Timercounter(){
        counter = counter - 1
        timeLabel.text = "Time : \(counter)"
        if counter == 0 {
            //game over
            for image in imageArray{
                image.isUserInteractionEnabled = false
            }
            timerCounter?.invalidate()
            timerHideImage?.invalidate()
            
            //control heightScore
            if score > heightScore{
                heightScore = score
                heightScoreLabel.text = "Height score : \(heightScore)"
                UserDefaults.standard.set(heightScore, forKey: "height_score")
            }
            
            //alert message
            
            let alert = UIAlertController(title: "Game Over", message: "do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let noButton = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel)
            
            let yesButton = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { UIAlertAction in
                //again code
                
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                
                self.counter = 10
                self.timeLabel.text = "Time : \(self.counter)"
                
                self.timerCounter = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.Timercounter), userInfo: nil, repeats: true)
                
                self.timerHideImage = Timer.scheduledTimer(timeInterval: self.dereceOfDiff, target: self, selector: #selector(self.hideImage), userInfo: self, repeats: true)
            }
            
            alert.addAction(noButton)
            alert.addAction(yesButton)
            present(alert,animated: true)
            
            
            //coreData save
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let newScore = NSEntityDescription.insertNewObject(forEntityName: "GameScore", into: context)
            
            newScore.setValue(score, forKey: "score")
            
            do{
                try context.save()
            }catch{
                print("error")
            }
        }
    }

}
