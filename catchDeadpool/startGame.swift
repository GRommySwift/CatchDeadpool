//
//  startGame.swift
//  catchDeadpool
//
//  Created by Roman on 05/03/2023.
//

import UIKit

class startGame: UIViewController {


    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var hardLevelSegmentedControl: UISegmentedControl!
    var highScoreDefault = 0
    var hardLevel: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedHighScoreDefault = UserDefaults.standard.object(forKey: "highscore")
        let storedHardLevel = UserDefaults.standard.object(forKey: "hardLevel")
        
        if storedHighScoreDefault == nil {
            highScoreDefault = 0
            highscoreLabel.text = "Highscore: \(highScoreDefault )"
        } else {
            highScoreDefault = storedHighScoreDefault as! Int
            highscoreLabel.text = "Highscore: \(highScoreDefault )"
        }
        
        if storedHardLevel == nil {
            hardLevel = 0.9
        } else {
            hardLevel = storedHardLevel as! Double
        }
        
        if hardLevel == 0.9 {
            hardLevelSegmentedControl.selectedSegmentIndex = 0
            hardLevelSegmentedControl.sendActions(for: .valueChanged)
        } else if hardLevel == 0.6 {
            hardLevelSegmentedControl.selectedSegmentIndex = 1
            hardLevelSegmentedControl.sendActions(for: .valueChanged)
        } else if hardLevel == 0.3 {
            hardLevelSegmentedControl.selectedSegmentIndex = 2
            hardLevelSegmentedControl.sendActions(for: .valueChanged)
        }
        
        hardLevelSegmentedControl.addTarget(self, action: #selector(hardLevelControl), for: .valueChanged)
    }
    
    @IBAction func startGame(_ sender: Any) {
        performSegue(withIdentifier: "gameSegue", sender: nil)
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        UserDefaults.standard.set(0, forKey: "highscore")
        highScoreDefault = UserDefaults.standard.object(forKey: "highscore") as! Int
        highscoreLabel.text = "Highscore: \(highScoreDefault)"
    }
    
    @objc func hardLevelControl(_ sender: UISegmentedControl) {
        if hardLevelSegmentedControl.selectedSegmentIndex == 0 {
            self.hardLevel = 0.9
            UserDefaults.standard.set(self.hardLevel, forKey: "hardLevel")
           print(hardLevel)
        } else if hardLevelSegmentedControl.selectedSegmentIndex == 1 {
            self.hardLevel = 0.6
            UserDefaults.standard.set(self.hardLevel, forKey: "hardLevel")
            print(hardLevel)
        } else if hardLevelSegmentedControl.selectedSegmentIndex == 2 {
            self.hardLevel = 0.3
            UserDefaults.standard.set(hardLevel, forKey: "hardLevel")
        }
    }
}
