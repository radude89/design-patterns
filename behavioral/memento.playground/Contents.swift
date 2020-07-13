import UIKit

/// # Memento
///
/// - Description: without violating encapsulation capture and externalize an
/// object's internal state so that the object can be restored to this state later.
///
/// ## Advantages:
///     - preserving encapsulation boundaries.
///     - it simplifies originator.
///
/// ## Disadvantages:
///     - using mementos might be expensive.
///     - hidden costs in caring for mementos.
///
/// ## When to use it:
///     - a snapshot of (some portion of) an object's state
///     must be saved so that it can be restored to that state later
///     - a direct interface to obtaining the state would expose
///     implementation details and break the object's encapsulation.
///     - 🗽 Use the Memento pattern when you want to produce
///     snapshots of the object’s state to be able to restore
///     a previous state of the object.
///     - 🏰 Use the pattern when direct access to the object’s
///     fields/getters/setters violates its encapsulation.
///
/// More to read: https://refactoring.guru/design-patterns/memento

/// **Example**

final class Editor {
    
    private var text: String?
    private var position = CGPoint(x: 0, y: 0)
    private var selectionWidth: CGFloat = 0
    
    func setText(_ text: String?) {
        self.text = text
    }
    
    func setPosition(_ position: CGPoint) {
        self.position = position
    }
    
    func setSelectionWidth(_ width: CGFloat) {
        selectionWidth = width
    }
    
    func makeSnapshot() -> Snapshot {
        print("We made of snapshot for the editor" +
            "with text: \(text ?? "")")
        return Snapshot(editor: self,
                        text: text,
                        position: position,
                        selectionWidth: selectionWidth)
    }

}

final class Snapshot {
    
    private let editor: Editor
    private var text: String?
    private var position: CGPoint
    private var selectionWidth: CGFloat
    
    init(editor: Editor,
         text: String?,
         position: CGPoint,
         selectionWidth: CGFloat) {
        self.editor = editor
        self.text = text
        self.position = position
        self.selectionWidth = selectionWidth
    }

    func restore() {
        print("We are restoring the editor with text: \(text ?? "")")
        editor.setText(text)
        editor.setPosition(position)
        editor.setSelectionWidth(selectionWidth)
    }
    
}

final class Command {
    private var backup: Snapshot?
    
    func makeBackup(from editor: Editor) {
        backup = editor.makeSnapshot()
    }
    
    func undo() {
        backup?.restore()
    }
}

var editor = Editor()
editor.setText("🍼")

let command = Command()
command.makeBackup(from: editor)

editor.setText("⚓️")
editor.setText(nil)

command.undo()
