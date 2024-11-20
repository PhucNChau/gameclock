import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabelA: UIButton!
    
    @IBOutlet weak var timerLabelB: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    var isNewGame: Bool = true
    var isATurn: Bool = true
    var timer: Timer = Timer()
    var timeSetting = 30
    var timerClockA: TimerClock = TimerClock(timer: 30)
    var timerClockB: TimerClock = TimerClock(timer: 30)
    
    @IBAction func TimerAPressed(_ sender: UIButton) {
        if isNewGame {
            startTimer(isATurn: true)
            isNewGame = false
        } else {
            timer.invalidate()
            isATurn = false
            startTimer(isATurn: isATurn)
        }
    }
    
    @IBAction func TimerBPressed(_ sender: UIButton) {
        if isNewGame {
            startTimer(isATurn: false)
            isNewGame = false
        } else {
            timer.invalidate()
            isATurn = true
            startTimer(isATurn: isATurn)
        }
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
        timer.invalidate()
        timerLabelA.isEnabled = true
        timerLabelA.layer.opacity = 1
        timerLabelB.isEnabled = true
        timerLabelB.layer.opacity = 1
        resetTimer()
    }
    
    // Function to reset all component to default value
    func resetTimer() {
        isNewGame = true
        timerClockA = TimerClock(timer: timeSetting)
        timerClockB = TimerClock(timer: timeSetting)
        timerLabelA.setTitle(timerClockA.formatTimer(), for: .normal)
        timerLabelB.setTitle(timerClockB.formatTimer(), for: .normal)
        timerLabelA.backgroundColor = UIColor(red: 69/255, green: 69/255, blue: 69/255, alpha: 1)
        timerLabelB.backgroundColor = UIColor(red: 69/255, green: 69/255, blue: 69/255, alpha: 1)
        playButton.isEnabled = false
        playButton.layer.opacity = 0.4
        pauseButton.isEnabled = false
        pauseButton.layer.opacity = 0.4
        resetButton.isEnabled = false
        resetButton.layer.opacity = 0.4
    }
    
    @objc func updateTimerA() {
        if timerClockA.timer > 1 {
            timerClockA.timer -= 1
        } else {
            timerClockA.timer = 0
            timerLabelA.backgroundColor = UIColor.systemRed
            timerLabelA.isEnabled = false
            timerLabelB.isEnabled = false
            pauseButton.isEnabled = false
            pauseButton.layer.opacity = 0.4
        }
        
        // Prevents animation of button when text is changed
        UIView.performWithoutAnimation {
            timerLabelA.setTitle(timerClockA.formatTimer(), for: .normal)
            timerLabelA.layoutIfNeeded()
        }
    }
    
    @objc func updateTimerB() {
        if timerClockB.timer > 1 {
            timerClockB.timer -= 1
        } else {
            timerClockB.timer = 0
            timerLabelB.backgroundColor = UIColor.systemRed
            timerLabelA.isEnabled = false
            timerLabelB.isEnabled = false
            pauseButton.isEnabled = false
            pauseButton.layer.opacity = 0.4
        }
        
        // Prevents animation of button when text is changed
        UIView.performWithoutAnimation {
            timerLabelB.setTitle(timerClockB.formatTimer(), for: .normal)
            timerLabelB.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timerLabelA.layer.cornerRadius = 30
        timerLabelB.layer.cornerRadius = 30
        
        resetTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

