import Foundation

/// # Proxy
///
/// - Description: provide a surrogate or placeholder for another object to control access to it.
///
/// ## Advantages:
///     - You can control the service object without clients knowing about it.
///     - You can manage the lifecycle of the service object when clients don’t care about it.
///     - The proxy works even if the service object isn’t ready or is not available.
///
/// ## Disadvantages:
///     - he response from the service might get delayed.
///
/// ## When to use it:
///     - Proxy is applicable whenever there is a need for a more versatible or sophisticated reference to an object than a simple pointer.
///     - 🦞 Lazy initialization (virtual proxy). This is when you have a heavyweight service object that wastes system resources by being always up, even though you only need it from time to time.
///     - 🦐 Access control (protection proxy). This is when you want only specific clients to be able to use the service object; for instance, when your objects are crucial parts of an operating system and clients are various launched applications (including malicious ones).
///     - 🐺 Local execution of a remote service (remote proxy). This is when the service object is located on a remote server. In this case, the proxy passes the client request over the network, handling all of the nasty details of working with the network.
///     - 🐛 Logging requests (logging proxy). This is when you want to keep a history of requests to the service object.
///     - 🐙 Caching request results (caching proxy). This is when you need to cache results of client requests and manage the life cycle of this cache, especially if results are quite large.
///     - 🦋 Smart reference. This is when you need to be able to dismiss a heavyweight object once there are no clients that use it.
///
/// More to read: https://refactoring.guru/design-patterns/proxy

/// **Example**

protocol Service {
    func requestData()
}

struct UserService: Service {
    func requestData() {
        print("Requesting users")
    }
}

class UserProxy: Service {
    
    private let userService: UserService
    
    init(_ userService: UserService) {
        self.userService = userService
    }
    
    func requestData() {
        if checkAccess() {
            userService.requestData()
            log()
        }
    }
    
    private func checkAccess() -> Bool {
        print("Checking access")
        return true
    }
    
    private func log() {
        print("Logging")
    }
}

struct APIClient {
    func loadUsers() {
        let service = UserService()
        let proxy = UserProxy(service)
        proxy.requestData()
    }
}

APIClient().loadUsers()
