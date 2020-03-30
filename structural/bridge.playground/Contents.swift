import Foundation

/// # Bridge
///
/// - Description: decouple an abstraction from its implementation so that the two can vary independently.
///
/// ## Advantages:
///     - decoupling interface and implementation.
///     - improved extensibility.
///     - hiding implementation details from clients.
///
/// ## When to use it:
///     - you want to avoid a permanent binding between an abstraction and its implementation. This might be the case, for example, when the implementation must be selected or switched at run-time.
///     - both the abstractions and their implementations should be extensible by subclassing. In this case, the Bridge pattern lets you combine the different abstractions and implementations and extend them independently.
///     - changes in the implementation of an abstraction should have no impact on clients; that is, their code should not have to be recompiled.
///     - you want to share an implementation among multiple objects.
///     - 🚜 Use the Bridge pattern when you want to divide and organize a monolithic class that has several variants of some functionality (for example, if the class can work with various database servers).
///     - 🏝 Use the pattern when you need to extend a class in several orthogonal (independent) dimensions.
///     - ⛺️ Use the Bridge if you need to be able to switch implementations at runtime.
///
/// More to read: https://refactoring.guru/design-patterns/bridge

/// **Example**

protocol Device {
    var name: String { get }
    
    func getChannel()
    func setChannel(_ channel: Int)
}

extension Device {
    func getChannel() {
        print("\(name) get channel.")
    }
    
    func setChannel(_ channel: Int) {
        print("\(name) set channel \(channel).")
    }
}

struct TV: Device {
    var name: String { "TV" }
}

struct Radio: Device {
    var name: String { "Radio" }
}

protocol RemoteControl {
    var device: Device { get set }
    
    func volumeUp()
    func volumeDown()
}

extension RemoteControl {
    func volumeUp() {
        print("Increasing volume of \(device.name).")
    }
    
    func volumeDown() {
        print("Decreasing volume of \(device.name).")
    }
}

class StandardRemoteControl: RemoteControl {
    
    var device: Device
    
    init(device: Device) {
        self.device = device
    }

    func mute() {
        print("\(device.name) is now muted.")
    }
}

class RadioRemoteControl: StandardRemoteControl {

    func shuffleAntena() {
        print("\(device.name) shuffled antena.")
    }
}

class TVRemoteControl: StandardRemoteControl {
    
    func turnOff() {
        print("\(device.name) is now turned off.")
    }
}

class GeniusRemoteControl: RemoteControl {
        
    var device: Device
    
    init(device: Device) {
        self.device = device
    }
}

class DolbySurroundRemoteControl: RemoteControl {
    
    var device: Device
    
    init(device: Device) {
        self.device = device
    }
    
    func noiseMachine() {
        print("BRING IT ON!!!!")
    }
}


let radio = Radio()
let tv = TV()

let remoteControl = StandardRemoteControl(device: radio)
remoteControl.volumeUp()
remoteControl.volumeDown()
remoteControl.device.getChannel()
remoteControl.device.setChannel(5)

print("\n## Changing to a new device ##")
remoteControl.device = tv
remoteControl.volumeUp()
remoteControl.volumeDown()
remoteControl.device.getChannel()
remoteControl.device.setChannel(15)

print("\n## Allocating a radio remote control ##")
let radioRemoteControl = RadioRemoteControl(device: radio)
radioRemoteControl.shuffleAntena()

print("\n## Allocating a TV remote control ##")
let tvRemoteControl = TVRemoteControl(device: tv)
tvRemoteControl.turnOff()

print("\n## Allocating a Genius remote control ##")
let geniusRemoteControl = GeniusRemoteControl(device: tv)
geniusRemoteControl.volumeDown()

print("\n## Allocating a Dolby Surround remote control ##")
let dolbyRemoteControl = DolbySurroundRemoteControl(device: tv)
dolbyRemoteControl.volumeUp()
dolbyRemoteControl.volumeUp()
dolbyRemoteControl.volumeUp()
dolbyRemoteControl.noiseMachine()
