
import Foundation

struct TimerClock {
    var timer: Int
    
    init(timer: Int) {
        self.timer = timer
    }
    
    // Function to transform number of seconds to string as m:ss
    func formatTimer() -> String {
        return "\(timer / 60):\(String(format: "%02d", (timer % 60)))"
    }
}
