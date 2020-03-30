import Foundation

/// # Factory Method
///
/// - Description: Defines an interface for creating an object, but let subclasses decide which class to instantiate.
///
/// ## Advantages:
///     - encapsulates the object creation process.
///     - eliminates the need to bind app specific classes int your code.
///     - gain flexibility when you want to add similar objects.
///
/// ## When to use it:
///     - a class can't anticipate the class of objects it must create.
///     - a class wants its subclasses to specify the objects it creates.
///     - classes delegate responsibility to one of several helper subclassess, and you want to localize the knowledge of which helper subclass is the delegate.
///     - 🏄 Use the Factory Method when you don’t know beforehand the exact types and dependencies of the objects your code should work with.
///     - 🏊‍♀️ Use the Factory Method when you want to provide users of your library or framework with a way to extend its internal components.
///     - ⛹️ Use the Factory Method when you want to save system resources by reusing existing objects instead of rebuilding them each time.
///
/// More to read: https://refactoring.guru/design-patterns/factory-method

/// **Example #1**

enum DocumentType {
    case text
    case pdf
    case audio
}

protocol Document {
    func open()
    func save()
    func close()
}

struct TextDocument: Document {
    func open() { print("Text Document opened") }
    func save() { print("Text Document saved") }
    func close() { print("Text Document closed") }
}

struct PDFDocument: Document {
    func open() { print("PDF Document opened") }
    func save() { print("PDF Document saved") }
    func close() { print("PDF Document closed") }
}

struct AudioDocument: Document {
    func open() { print("Audio Document opened") }
    func save() { print("Audio Document saved") }
    func close() { print("Audio Document closed") }
}

enum DocumentFactory {
    static func makeDocument(ofType type: DocumentType) -> Document {
        switch type {
        case .audio:
            return AudioDocument()
        case .pdf:
            return PDFDocument()
        case .text:
            return TextDocument()
        }
    }
}

let textDocument = DocumentFactory.makeDocument(ofType: .text)
textDocument.open()

let audioDocument = DocumentFactory.makeDocument(ofType: .audio)
audioDocument.save()

/// **Example #2**

protocol Service {
    var endpoint: URL { get }
}

struct LocalService: Service {
    var endpoint: URL { URL(string: "http://localhost:8000/")! }
}

struct UATService: Service {
    var endpoint: URL { URL(string: "https://mydomain.uat.com/")! }
}

protocol ServiceFactory {
    static func makeService() -> Service
}

enum LocalServiceFactory: ServiceFactory {
    static func makeService() -> Service {
        return LocalService()
    }
}

enum UATServiceFactory: ServiceFactory {
    static func makeService() -> Service {
        return UATService()
    }
}

let localService = LocalServiceFactory.makeService()
print(localService.endpoint)

let uatService = UATServiceFactory.makeService()
print(uatService.endpoint)
