//
//  RandomQuestionStrategy.swift
//  Rabble Wabble
//
//  Created by Porori on 5/16/24.
//

import Foundation
import GameplayKit

public class RandomQuestionStrategy: QuestionStrategy {
    public var correctCount: Int = 0
    public var incorrectCount: Int = 0
    public let questionGroup: QuestionGroup
    private var questionIndex = 0
    private let questions: [Question]
    
    public init(questionGroup: QuestionGroup) {
        self.questionGroup = questionGroup
        
        let randomSource = GKRandomSource.sharedRandom()
        self.questions = randomSource.arrayByShufflingObjects(in: questionGroup.questions) as! [Question]
    }
    
    public var title: String {
        return questionGroup.title
    }
    
    public func currentQuestion() -> Question {
        return questions[questionIndex]
    }
    
    public func advanceToNextQuestion() -> Bool {
        guard questionIndex + 1 < questions.count else {
            return false
        }
        questionIndex += 1
        return true
    }
    
    public func markQuestionRight(_ question: Question) {
        correctCount += 1
    }
    
    public func markQuestionWrong(_ question: Question) {
        incorrectCount += 1
    }
    
    public func questionIndexTitle() -> String {
        return "\(questionIndex + 1)/\(questions.count)"
    }
}
