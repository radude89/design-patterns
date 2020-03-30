import Foundation

/// # Template
///
/// - Description: define the skeleton of an algorithm in an operation, deferring some steps to subclasses. Template Method lets subclasses redefine certains steps of an algorithm without changing the algorithm's structure.
///
/// ## Advantages:
///     - fundamental technique for code reuse.
///     - important in class libraries.
///
/// ## Disadvantages:
///     - Template methods tend to be harder to maintain the more steps they have.
///     - You might violate the Liskov Substitution Principle by suppressing a default step implementation via a subclass.
///
/// ## When to use it:
///     - to implement the invariant parts of an algorithm once and leave it up to subclasses to implement the behavior that can vary.
///     - when common behavior among subclasses should be factored and localized in a common class to avoid code duplication
///     - to control subclasses extensions.
///     - 🍇 Use the Template Method pattern when you want to let clients extend only particular steps of an algorithm, but not the whole algorithm or its structure.
///     - 🥝 Use the pattern when you have several classes that contain almost identical algorithms with some minor differences. As a result, you might need to modify all classes when the algorithm changes.
///
/// More to read: https://refactoring.guru/design-patterns/template-method

/// **Example**

protocol PermissionAccessor {
    var hasAccess: Bool { get }
    
    func requestAccess(_ completion: @escaping (Bool) -> ())
    func willReceiveAccess()
    func didReceiveAccess()
}

extension PermissionAccessor {
    func requestAccess(_ completion: @escaping (Bool) -> ()) {
        guard !hasAccess else {
            print("This device already has access.")
            completion(true)
            return
        }

        willReceiveAccess()
        completion(true)
        didReceiveAccess()
    }
    
    func willReceiveAccess() {}
    func didReceiveAccess() {}
}

final class CameraAccess: PermissionAccessor {
    var hasAccess: Bool { false }
    
    func willReceiveAccess() {
        print("Camera will receive access")
    }
}

final class MicrophoneAccess: PermissionAccessor {
    var hasAccess: Bool { true }
}

let accessors: [PermissionAccessor] = [CameraAccess(), MicrophoneAccess()]
accessors.forEach { accessor in
    accessor.requestAccess { granted in
        print("\(granted ? "Granted" : "Not Granted") access to \(accessor)")
    }
}
