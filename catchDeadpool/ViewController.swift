//
//  ViewController.swift
//  catchDeadpool
//
//  Created by Roman on 04/03/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var deadpoolCollection: [UIImageView]!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var score = 0
    var highScore = 0
    var timer = Timer()
    var counter = 0
    var hideTimer = Timer()
    var hardLevel = 0.0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        timerLabel.isHidden = false
        scoreLabel.isHidden = false
        scoreLabel.text = "Score: \(score)"
        hardLevel = UserDefaults.standard.object(forKey: "hardLevel") as! Double
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        for i in (0...(deadpoolCollection.count - 1)) {
            let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(plusScore))
            deadpoolCollection[i].isUserInteractionEnabled = true
            deadpoolCollection[i].addGestureRecognizer(recognizer1)
            deadpoolCollection[i].isHidden = true
        }
        
        counter = 10
        timerLabel.text = String(counter)
        
        hideTimer = Timer.scheduledTimer(timeInterval: hardLevel, target: self, selector: #selector(hidePool), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    
    
    @objc func plusScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    // MARK: RANDOM
    @objc func hidePool() {
        for pool in deadpoolCollection {
            pool.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(deadpoolCollection.count)))
        deadpoolCollection[random].isHidden = false
    }
    // MARK: TIMER
    @objc func countdown() {
        counter -= 1
        timerLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for pool in deadpoolCollection {
                pool.isHidden = true
            }
            
            if self.score > self.highScore {
                self.highScore = self.score
                self.highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            // ADD ALERT
            
            let alert = UIAlertController(title: "Thats all", message: "u wanna play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "no", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
                self.performSegue(withIdentifier: "startGame", sender: nil)
            }
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timerLabel.text = String(self.counter)
                self.hideTimer = Timer.scheduledTimer(timeInterval: self.hardLevel, target: self, selector: #selector(self.hidePool), userInfo: nil, repeats: true)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

