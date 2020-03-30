import Foundation

/// # State
///
/// - Description: allow an object to alter its behavior when its internal state changes. The object will appear to change its class.
///
/// ## Advantages:
///     - it localizes state-specific behavior and partitions behavior for different states.
///     - it makes state transitions explicit.
///     - state objects can be shared.
///
/// ## Disadvantages:
///     -
///
/// ## When to use it:
///     - an object's behavior depends on its state, and it must change its behavior at run-time depending on that state.
///     - operations have large, multipart conditional statements that depend on the object's state.
///     - 🎿 Use the State pattern when you have an object that behaves differently depending on its current state, the number of states is enormous, and the state-specific code changes frequently.
///     - ⛷ Use the pattern when you have a class polluted with massive conditionals that alter how the class behaves according to the current values of the class’s fields.
///     - 🏇 Use State when you have a lot of duplicate code across similar states and transitions of a condition-based state machine.
///
/// More to read: https://refactoring.guru/design-patterns/state

/// **Example #1**

protocol TrackingState {
    func startTracking()
    func stopTracking()
}

final class EnabledTrackingState: TrackingState {
    func startTracking() {
        print("Tracking state start tracking.")
    }
    
    func stopTracking() {
        print("EnabledTracker: Tracking state stopped tracking.")
    }
}

final class DisabledTrackingState: TrackingState {
    func startTracking() {
        print("You don't have permissions to start tracking.")
        print("Asking user for permissions.")
        print("User accepted.")
        
    }
    
    func stopTracking() {
        print("DisabledTracker: Tracking state stopped tracking.")
    }
}

final class LocationTracker {
    private var trackingState: TrackingState? = DisabledTrackingState()
    
    func startTracking() {
        trackingState?.startTracking()
    }
    
    func stopTracking() {
        trackingState?.stopTracking()
    }
    
    func update(trackingState: TrackingState) {
        self.trackingState = trackingState
    }
}

let tracker = LocationTracker()
tracker.startTracking()
tracker.stopTracking()

tracker.update(trackingState: EnabledTrackingState())
tracker.startTracking()
tracker.stopTracking()

/// **Example #2**

final class Context {
    private var state: State {
        didSet {
            state.update(self)
        }
    }
    
    init(_ state: State) {
        self.state = state
    }
    
    func transition(to state: State) {
        print("Transitioning to state \(state.name).")
        self.state = state
    }
    
    func request1() {
        state.handle1()
    }
    
    func request2() {
        state.handle2()
    }
}

protocol State: AnyObject {
    var name: String { get }
    
    func update(_ context: Context)
    func handle1()
    func handle2()
}

final class BasicState: State {
    var name: String { "basic \(UUID().uuidString)" }
    
    private(set) weak var context: Context?
    
    func update(_ context: Context) {
        self.context = context
    }
    
    func handle1() {
        print("State \(name) handling 1.")
    }
    
    func handle2() {
        print("State \(name) handling 2.")
    }
}

final class UpdatingState: State {
    var name: String { "updating \(UUID().uuidString)" }
    
    private(set) weak var context: Context?
    
    func update(_ context: Context) {
        self.context = context
    }
    
    func handle1() {
        print("State \(name) handling 1.")
    }
    
    func handle2() {
        print("State \(name) handling 2.")
    }
}


let context = Context(BasicState())

context.request1()
context.request2()

context.transition(to: UpdatingState())
context.request1()
