import UIKit

class RemoteControl {
    var device: Device
    init(device: Device) {
        self.device = device
    }
    func togglePower() {
        device.turnOn()
    }
}

class AdvanceRemoteControl: RemoteControl {
    func mute() {
        device.setVolume(to: 0)
    }
}

protocol Device {
    func turnOn()
    func setVolume(to: Int)
}

struct TV: Device {
    func turnOn() {
        print("Turn on TV")
    }
    
    func setVolume(to percent: Int) {
        print("Set TV volume to \(percent)")
    }
}

struct Radio: Device {
    func turnOn() {
        print("Turn on Radio")
    }
    
    func setVolume(to percent: Int) {
        print("Set Tradio volume to \(percent)")
    }
}
