/*:
 [Previous](@previous)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next](@next)
 
 # Delegation
 - - - - - - - - - -
 ![Delegation Diagram](Delegation_Diagram.png)
 
 The delegation pattern allows an object to use a helper object to perform a task, instead of doing the task itself.
 
 This allows for code reuse through object composition, instead of inheritance.
 
 ## Code Example
 */
import UIKit

public protocol MenuViewControllerDelegate: AnyObject {
    func menuViewController(_ menuViewController: MenuViewController, didSelectItemAtIndex index: Int)
}

public class MenuViewController: UIViewController {
    
    // delegates are weak to make sure the cycles aren't retained
    public weak var delegate: MenuViewControllerDelegate?
    
    @IBOutlet public var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private let items = ["item 1", "item 2", "item 3"]
}

// These delegations are methods that 'helper' object need
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // delegating object is MenuViewController - thus self
        delegate?.menuViewController(self, didSelectItemAtIndex: indexPath.row)
    }
}
