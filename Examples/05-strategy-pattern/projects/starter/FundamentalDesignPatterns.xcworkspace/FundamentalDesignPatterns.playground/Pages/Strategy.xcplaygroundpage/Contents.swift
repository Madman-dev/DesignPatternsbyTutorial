/*:
 [Previous](@previous)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next](@next)
 
 # Strategy
 - - - - - - - - - -
 ![Strategy Diagram](Strategy_Diagram.png)
 
 The strategy pattern defines a family of interchangeable objects.
 
 This pattern makes apps more flexible and adaptable to changes at runtime, instead of requiring compile-time changes.
 
 ## Code Example
 */
import UIKit

public protocol MovieRatingStrategy {
    var ratingServiceName: String { get }
    func fetchRating(for movieTitle: String, success: (_ rating: String, _ review: String) -> ())
}

public class RottenTomatoesClient: MovieRatingStrategy {
    public let ratingServiceName = "Rotten Tomatoes"
    
    public func fetchRating(for movieTitle: String, success: (String, String) -> ()) {
        let rating = "95%"
        let review = "Awesome"
        success(rating, review)
    }
}


public class IMDbClient: MovieRatingStrategy {
    
    public let ratingServiceName: String = "IMDb"
    public func fetchRating(for movieTitle: String, success: (String, String) -> ()) {
        let rating = "3 / 10"
        let review = "huh..."
        success(rating, review)
    }
}

public class MovieRatingViewController: UIViewController {
    public var movieRatingClient: MovieRatingStrategy!
    
    @IBOutlet public var movieTitleTextfield: UITextField!
    @IBOutlet public var ratingServiceNameLabel: UILabel!
    @IBOutlet public var ratingLabel: UILabel!
    @IBOutlet public var reviewLabel: UILabel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        ratingServiceNameLabel.text = movieRatingClient.ratingServiceName
    }
    
    @IBAction public func searchButtonPressed(sender: Any) {
        guard let movieTitle = movieTitleTextfield.text else { return }
        movieRatingClient.fetchRating(for: movieTitle) { rating, review in
            self.ratingLabel.text = rating
            self.reviewLabel.text = review
        }
    }
}
