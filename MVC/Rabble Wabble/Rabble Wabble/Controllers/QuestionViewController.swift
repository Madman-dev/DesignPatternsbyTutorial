//
//  ViewController.swift
//  Rabble Wabble
//
//  Created by Porori on 5/15/24.
//

import UIKit

public protocol QuestionViewControllerDelegate: AnyObject {
    func questionViewController(_ viewController: QuestionViewController,
                                didCancel questionGroup: QuestionGroup,
                                at questionIndex: Int)
    
    func questionViewController(_ viewController: QuestionViewController,
                                didComplete questionGroup: QuestionGroup
    )
}

public class QuestionViewController: UIViewController {
    public var questionGroup: QuestionGroup! {
        didSet {
            navigationItem.title = questionGroup.title
        }
    }
    public var questionIndex = 0
    public var correctCount = 0
    public var incorrectCount = 0
    
    public var questionView: QuestionView! {
        guard isViewLoaded else { return nil }
        return (view as! QuestionView)
    }
    
    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        return item
    }()
    
    public weak var delegate: QuestionViewControllerDelegate?

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelButton()
        showQuestion()
    }
    
    private func showQuestion() {
        let questions = questionGroup.questions[questionIndex]
        questionView.answerLabel.text = questions.answer
        questionView.hintLabel.text = questions.hint
        questionView.promptLabel.text = questions.prompt
        
        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
        
        questionIndexItem.title = "\(questionIndex + 1)/" + "\(questionGroup.questions.count)"
    }
    
    @IBAction func toggleAnswerLabels(_ sender: AnyObject) {
        // update label to hidden or not according to each tap.
        questionView.answerLabel.isHidden = !questionView.answerLabel.isHidden
        questionView.hintLabel.isHidden = !questionView.hintLabel.isHidden
    }
    
    @IBAction func handleCorrect(_ sender: Any) {
        correctCount += 1
        questionView.correctCountLabel.text = "\(correctCount)"
        showNextQuestion()
    }
    
    @IBAction func handleIncorrect(_ sender: Any) {
        incorrectCount += 1
        questionView.incorrenctCountLabel.text = "\(incorrectCount)"
        showNextQuestion()
    }
    
    private func showNextQuestion() {
        questionIndex += 1
        guard questionIndex < questionGroup.questions.count else {
            delegate?.questionViewController(self, didComplete: questionGroup)
            return
        }
        showQuestion()
    }
    
    private func setupCancelButton() {
        let action = #selector(handleCancelPressed)
        let image = UIImage(named: "ic_menu")
        navigationItem.leftBarButtonItem =
        UIBarButtonItem(image: image, style: .plain, target: self, action: action)
    }
    
    @objc func handleCancelPressed(_ sender: UIBarButtonItem) {
        print("버튼이 눌렸습니다")
        delegate?.questionViewController(self, didCancel: questionGroup, at: questionIndex)
    }
}
