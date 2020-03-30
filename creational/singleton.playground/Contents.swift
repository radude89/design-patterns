import UIKit

/// # Singleton
///
/// - Description: Ensure a class only has one instance, and provide a global point of access to it.
///
/// ## Advantages:
///     - controlled access to sole instance.
///     - reduced name space.
///     - permits refinement of operations and representation.
///     - permits a variable number of instances.
///     - more flexible than class operations.
///
/// ## Disadvantages:
///     - violates SRP.
///     - difficult to unit test.
///     - requires special treatment in a multithreaded environment so that multiple threads won’t create a singleton object several times.
///
/// ## When to use it:
///     - there must be exactly one instance of a class, and it must be accessible to clients from a well-known access point.
///     - when the sole instance should be extensible by subclassing, and clients should be able to use an extended instance without modifying their code.
///     - 🏸 Use the Singleton pattern when a class in your program should have just a single instance available to all clients; for example, a single database object shared by different parts of the program.
///     - 🏀 Use the Singleton pattern when you need stricter control over global variables.
///
/// More to read: https://refactoring.guru/design-patterns/singleton

/// **Example**

final class Database {
    static let sharedInstance = Database()
    
    func connect() { print("Connecting to tables") }
    func fetchData() { print("Fetching data") }
    func closeConnection() { print("Close connection") }
}

Database.sharedInstance.connect()
Database.sharedInstance.fetchData()
Database.sharedInstance.closeConnection()
