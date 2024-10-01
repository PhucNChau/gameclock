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
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    var newGame: Bool = true
    var isATurn: Bool = true
    var timer: Timer = Timer()
    var remainingTimeA = 100
    var remainingTimeB = 100
    
    @IBAction func TimerAPressed(_ sender: UIButton) {
        timer.invalidate()
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimerB)), userInfo: nil, repeats: true)
        isATurn = false
        startTimer(isATurn: isATurn)
    }
    
    @IBAction func TimerBPressed(_ sender: UIButton) {
        timer.invalidate()
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimerA)), userInfo: nil, repeats: true)
        isATurn = true
        startTimer(isATurn: isATurn)
    }
    
    func startTimer(isATurn: Bool) {
        pauseButton.isEnabled = true
        pauseButton.layer.opacity = 1
        resetButton.isEnabled = true
        resetButton.layer.opacity = 1
        let startedTimer = isATurn ? #selector(self.updateTimerA) : #selector(self.updateTimerB)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (startedTimer), userInfo: nil, repeats: true)
        timerLabelA.isEnabled = isATurn
        timerLabelA.backgroundColor = isATurn ? UIColor.systemGreen : UIColor(red: 69/255, green: 69/255, blue: 69/255, alpha: 1)
        timerLabelB.isEnabled = !isATurn
        timerLabelB.backgroundColor = !isATurn ? UIColor.systemGreen : UIColor(red: 69/255, green: 69/255, blue: 69/255, alpha: 1)
    }
    
    @IBAction func PlayButtonPressed(_ sender: Any) {
        playButton.isEnabled = false
        playButton.layer.opacity = 0.4
        pauseButton.isEnabled = true
        pauseButton.layer.opacity = 1
        timerLabelA.isEnabled = true
        timerLabelA.layer.opacity = 1
        timerLabelB.isEnabled = true
        timerLabelB.layer.opacity = 1
        startTimer(isATurn: isATurn)
    }
    
    @IBAction func PauseButtonPressed(_ sender: Any) {
        pauseButton.isEnabled = false
        pauseButton.layer.opacity = 0.4
        playButton.isEnabled = true
        playButton.layer.opacity = 1
        timer.invalidate()
        timerLabelA.isEnabled = false
        timerLabelA.layer.opacity = 0.4
        timerLabelB.isEnabled = false
        timerLabelB.layer.opacity = 0.4
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
        UIView.performWithoutAnimation {
            timerLabelB.setTitle(formatTimer(remainingTimeB), for: .normal)
            timerLabelB.layoutIfNeeded()
        }
    }
    
    func formatTimer(_ seconds: Int) -> String {
        return "\(seconds / 60):\(seconds % 60)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        timerLabelA.layer.cornerRadius = 30
        timerLabelB.layer.cornerRadius = 30
        timerLabelA.setTitle(formatTimer(remainingTimeA), for: .normal)
        timerLabelB.setTitle(formatTimer(remainingTimeB), for: .normal)
        timerLabelA.backgroundColor = UIColor(red: 69/255, green: 69/255, blue: 69/255, alpha: 1)
        timerLabelB.backgroundColor = UIColor(red: 69/255, green: 69/255, blue: 69/255, alpha: 1)
        playButton.isEnabled = false
        playButton.layer.opacity = 0.4
        pauseButton.isEnabled = false
        pauseButton.layer.opacity = 0.4
        resetButton.isEnabled = false
        resetButton.layer.opacity = 0.4
    }

}

