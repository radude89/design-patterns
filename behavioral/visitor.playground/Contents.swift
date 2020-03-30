import UIKit

/// # Visitor
///
/// - Description: represent an operation to be performed on the elements of an object structure. Visitor lets you define a new operation without changing the classes of the elements on which it operates.
///
/// ## Advantages:
///     - visitor makes adding new operations easy.
///     - a visitor gathers related operations and separates unrelated ones.
///
/// ## Disadvantages:
///     - adding new concrete classes is hard.
///     - visitor can accumulate state.
///     - breaking encapsulation.
///     - You need to update all visitors each time a class gets added to or removed from the element hierarchy.
///     - Visitors might lack the necessary access to the private fields and methods of the elements that they’re supposed to work with.
///
/// ## When to use it:
///     - an object structure contains many classes of objects with differing interfaces, and you want to perform operations on these objects that depend on their concrete classes.
///     - many distinct and unrelated operations need to be performed on objects in an object structure, and you want to avoid polluting their classes with these operations.
///     - the classes defining the object structure rarely change, but you often want to define new operations over the structure.
///     - ☔️ Use the Visitor when you need to perform an operation on all elements of a complex object structure (for example, an object tree).
///     - 🍌 Use the Visitor to clean up the business logic of auxiliary behaviors.
///     - 🌥 Use the pattern when a behavior makes sense only in some classes of a class hierarchy, but not in others.
///
/// More to read: https://refactoring.guru/design-patterns/visitor

/// **Example**

protocol Shape {
    func move(point: CGPoint)
    func draw()
    func accept(visitor: Visitor)
}

final class Dot: Shape {
    func move(point: CGPoint) {
        print("Moving dot")
    }
    
    func draw() {
        print("Drawing dot")
    }
    
    func accept(visitor: Visitor) {
        visitor.visitDot(self)
    }
}

final class Circle: Shape {
    func move(point: CGPoint) {
        print("Moving circle")
    }
    
    func draw() {
        print("Drawing circle")
    }
    
    func accept(visitor: Visitor) {
        visitor.visitCircle(self)
    }
}

final class Rectangle: Shape {
    func move(point: CGPoint) {
        print("Moving rectangle")
    }
    
    func draw() {
        print("Drawing rectangle")
    }
    
    func accept(visitor: Visitor) {
        visitor.visitRectangle(self)
    }
}

protocol Visitor {
    func visitDot(_ dot: Dot)
    func visitCircle(_ rectangle: Circle)
    func visitRectangle(_ rectangle: Rectangle)
}

final class XMLExportVisitor: Visitor {
    func visitDot(_ dot: Dot) {
        print("Exporting dot as an XML")
    }
    
    func visitCircle(_ rectangle: Circle) {
        print("Exporting circle as an XML")
    }
    
    func visitRectangle(_ rectangle: Rectangle) {
        print("Exporting rectangle as an XML")
    }
}

let xmlExporter = XMLExportVisitor()
xmlExporter.visitDot(Dot())
xmlExporter.visitRectangle(Rectangle())
xmlExporter.visitCircle(Circle())
