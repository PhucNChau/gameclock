//
//  ViewController.swift
//  GameClock
//
//  Created by Phuc Chau on 29/09/2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabelA: UIButton!
    
    @IBOutlet weak var timerLabelB: UIButton!
    
    var newGame: Bool = true
    var timer: Timer = Timer()
    var remainingTimeA = 100
    var remainingTimeB = 100
    
    @IBAction func TimerAPressed(_ sender: UIButton) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimerB)), userInfo: nil, repeats: true)
    }
    
    @IBOutlet weak var test: UITextField!
    
    
    @IBAction func TimerBPressed(_ sender: UIButton) {
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimerA)), userInfo: nil, repeats: true)
    }
    
    @IBAction func PlayButtonPressed(_ sender: Any) {
    }
    
    @IBAction func PauseButtonPressed(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func ResetButtonPressed(_ sender: Any) {
    }
    
    @IBAction func SettingButtonPressed(_ sender: Any) {
    }
    
    @objc func updateTimerA() {
        remainingTimeA -= 1
        UIView.performWithoutAnimation {
            timerLabelA.setTitle(formatTimer(remainingTimeA), for: .normal)
            timerLabelA.layoutIfNeeded()
        }
        
    }
    
    @objc func updateTimerB() {
        remainingTimeB -= 1
        timerLabelB.setTitle(formatTimer(remainingTimeB), for: .normal)
        timerLabelA.layoutIfNeeded()
        test.text = formatTimer(remainingTimeB)
    }
    
    func formatTimer(_ seconds: Int) -> String {
        return "\(seconds / 60):\(seconds % 60)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        timerLabelA.layer.cornerRadius = 30
        timerLabelB.layer.cornerRadius = 30
        
        print(timerLabelA.layer.duration)
        
        timerLabelA.setTitle(formatTimer(remainingTimeA), for: .normal)
        timerLabelB.setTitle(formatTimer(remainingTimeB), for: .normal)
        
    }

}

