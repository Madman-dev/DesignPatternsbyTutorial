/*:
 [Previous](@previous)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next](@next)
 
 # Model-view-controller (MVC)
 - - - - - - - - - -
 ![MVC Diagram](MVC_Diagram.png)
 
 The model-view-controller (MVC) pattern separates objects into three types: models, views and controllers.
 
 **Models** hold onto application data. They are usually structs or simple classes.
 
 **Views** display visual elements and controls on screen. They are usually subclasses of `UIView`.
 
 **Controllers** coordinate between models and views. They are usually subclasses of `UIViewController`.
 
 ## Code Example
 */
import UIKit

//struct Address {
//    var name: String
//    var address: String
//    var phoneNumber: Int
//}

struct Address {
    var street: String
    var city: String
    var state: String
    var zipcode: String
}

class AddressView: UIView {
    @IBOutlet var streetTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var stateTextField: UITextField!
    @IBOutlet var zipcodeTextField: UITextField!
}

class AddressViewController: UIViewController {
    var address: Address? {
        didSet {
            // update data when data is set after viewDidLoad()
            updateFromAddress()
        }
    }
    var addressView: AddressView! {
        guard isViewLoaded else { return nil }
        return (view as! AddressView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateFromAddress()
    }
    
    private func updateFromAddress() {
        guard let addressView = addressView,
              let address = address else { return }
        
        addressView.streetTextField.text = address.street
        addressView.cityTextField.text = address.city
        addressView.stateTextField.text = address.state
        addressView.zipcodeTextField.text = address.zipcode
    }
    
    @IBAction func updateManually(sender: AnyObject) {
        guard let street = addressView.streetTextField.text,
        let city = addressView.cityTextField.text,
        let state = addressView.stateTextField.text,
        let zipcode = addressView.zipcodeTextField.text,
            street.count > 0, city.count > 0, state.count > 0, zipcode.count > 0
        else { return }
        
        address = Address(
            street: street,
            city: city,
            state: state,
            zipcode: zipcode
        )
    }
}

// In MVC, Controller holds both model and views and updates the data when an action is called upon or automatically through observation.
