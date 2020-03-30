import Foundation

/// # Facade
///
/// - Description: provide a unified interface to a set of interfaces in a subsystem. Facade defines a higher-level interface that makes the subsystem easier to use.
///
/// ## Advantages:
///     - it shields clients from subsystem components, thereby reducing the number of objects that clients deal with and making the subsystem easier to use.
///     - it promotes weak coupling between the subsystem and its clients.
///     - it doesn't prevent applications from using subsystem classes if they need to.
///
/// ## Disadvantages:
///     - A facade can become a god object coupled to all classes of an app.
///
/// ## When to use it:
///     - you want to provide a simple interface to a complex subsystem.
///     - there are many dependencies between clients and the implementation classes of an abstraction.
///     - you want to layer your subsystems.
///     - 🐛 Use the Facade pattern when you need to have a limited but straightforward interface to a complex subsystem.
///     - 🐝 Use the Facade when you want to structure a subsystem into layers.
///
/// More to read: https://refactoring.guru/design-patterns/facade

/// **Example**

class ChatFacade {
    
    func startConversation<T>(from context: T.Type) {
        saveChatContext(String(describing: context))
        authenticateUser()
        authoriseUser()
        loadChatSDK { loaded in
            if loaded {
                initiateChat()
                loadUIForChat()
                print("Chat setup finished. You can chat with the other person.")
            }
        }
    }
    
    private func saveChatContext(_ context: String) {
        print("Defining context - storing \(context)")
    }
    
    private func authenticateUser() {
        print("Authenticating user")
    }
    
    private func authoriseUser() {
        print("Authorising user")
    }
    
    private func loadChatSDK(completion: (Bool) -> ()) {
        print("Loading chat SDK")
        completion(true)
    }
    
    private func initiateChat() {
        print("Initiating chat")
    }
    
    private func loadUIForChat() {
        print("Loading Views and all UI elements")
    }
}

class MyApp {
    
    private let chatFacade = ChatFacade()
    
    func startChat() {
        chatFacade.startConversation(from: MyApp.self)
    }
}

let app = MyApp()
app.startChat()
