//
//  ViewController.swift
//  Rabble Wabble
//
//  Created by Porori on 5/15/24.
//

import UIKit

public protocol QuestionViewControllerDelegate: AnyObject {
    func questionViewController(_ viewController: QuestionViewController,
                                didCancel questionGroup: QuestionStrategy)
    
    func questionViewController(_ viewController: QuestionViewController,
                                didComplete QuestionStrategy: QuestionStrategy)
}

public class QuestionViewController: UIViewController {
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
    public var questionStrategy: QuestionStrategy! {
        didSet {
            navigationItem.title = questionStrategy.title
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelButton()
        showQuestion()
    }
    
    private func showQuestion() {
        // questionGroup to questionStrategy
        let questions = questionStrategy.currentQuestion()
        questionView.answerLabel.text = questions.answer
        questionView.hintLabel.text = questions.hint
        questionView.promptLabel.text = questions.prompt
        
        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
        
        questionIndexItem.title = questionStrategy.questionIndexTitle()
    }
    
    @IBAction func toggleAnswerLabels(_ sender: AnyObject) {
        // update label to hidden or not according to each tap.
        questionView.answerLabel.isHidden = !questionView.answerLabel.isHidden
        questionView.hintLabel.isHidden = !questionView.hintLabel.isHidden
    }
    
    @IBAction func handleCorrect(_ sender: Any) {
        // abstraction using Strategy
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionRight(question)
        
        questionView.correctCountLabel.text = String(questionStrategy.correctCount)
        showNextQuestion()
    }
    
    @IBAction func handleIncorrect(_ sender: Any) {
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionWrong(question)
        
        questionView.incorrenctCountLabel.text = String(questionStrategy.incorrectCount)
        showNextQuestion()
    }
    
    private func showNextQuestion() {
        questionIndex += 1
        guard questionStrategy.advanceToNextQuestion() else {
            delegate?.questionViewController(self, didComplete: questionStrategy)
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
        delegate?.questionViewController(self, didCancel: questionStrategy)
    }
}
