import Foundation

/// # Command
///
/// - Description: encapsulates a request as an object, thereby letting you parametrize
/// clients with different requests, queue or log requests, and support undoable operations.
///
/// ## Advantages:
///     - decouples the object that invokes the operation
///     from the one that knows how to perform it.
///     - it's easy to add new Commands, because you don't have
///     to change existing classes.
///     - you can assemble a set of simple commands into a
///     complex one.
///     - you can implement undo/redo.
///     - you can implement deferred execution of operations.
///
/// ## When to use it:
///     - parametrize objects by an action to perform.
///     - specify, queue, and execute requests at different times.
///     - support undo.
///     - support logging changes so that they can be reapplied
///     in case of a system crash.
///     - structure a system around high-level operations built on
///     primitives operations.
///     - 🍱 Use the Command pattern when you want to parametrize
///     objects with operations.
///     - 🥟 Use the Command pattern when you want to queue
///     operations, schedule their execution, or execute them remotely.
///     - 🥗 Use the Command pattern when you want to implement
///     reversible operations.
///
/// More to read: https://refactoring.guru/design-patterns/command

/// **Example**

protocol Command {
    var name: String { get }
    
    func execute()
}

extension Command {
    func execute() {
        print("\(name) command has been executed.")
    }
}

struct CopyCommand: Command {
    let name = "Copy"
}

struct CutCommand: Command {
    let name = "Cut"
}

struct MoveCommand: Command {
    let name = "Move"
}

struct PasteCommand: Command {
    let name = "Paste"
}

class Invoker {
    private var copyCommand: Command
    private var cutCommand: Command
    private var moveCommand: Command
    private var pasteCommand: Command
    
    init(copyCommand: Command = CopyCommand(),
         cutCommand: Command = CutCommand(),
         moveCommand: Command = MoveCommand(),
         pasteCommand: Command = PasteCommand()) {
        self.copyCommand = copyCommand
        self.cutCommand = cutCommand
        self.moveCommand = moveCommand
        self.pasteCommand = pasteCommand
    }
    
    func prepare() {
        copyCommand.execute()
        moveCommand.execute()
        cutCommand.execute()
        pasteCommand.execute()
    }
}

let invoker = Invoker()
invoker.prepare()
