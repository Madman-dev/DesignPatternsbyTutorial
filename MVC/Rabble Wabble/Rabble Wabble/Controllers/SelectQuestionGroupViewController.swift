//
//  SelectQuestionGroupViewController.swift
//  Rabble Wabble
//
//  Created by Porori on 5/15/24.
//

import UIKit

public class SelectQuestionGroupViewController: UIViewController {
    @IBOutlet internal var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    public let questionGroups = QuestionGroup.allGroups()
    private var selectedQuestionGroup: QuestionGroup!
    
}

extension SelectQuestionGroupViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionGroups.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell") as! QuestionGroupCell
        let questionGroup = questionGroups[indexPath.row]
        cell.titleLabel.text = questionGroup.title
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedQuestionGroup = questionGroups[indexPath.row]
        return indexPath
    }
    
    // triggered after segue is performed
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // update the data?
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? QuestionViewController else { return }
        viewController.questionGroup = selectedQuestionGroup
    }
}
