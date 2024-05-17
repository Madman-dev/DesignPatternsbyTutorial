//
//  QuestionStrategy.swift
//  Rabble Wabble
//
//  Created by Porori on 5/16/24.
//

import Foundation

public protocol QuestionStrategy {
    var title: String { get }
    var correctCount: Int { get }
    var incorrectCount: Int { get }
    
    func advanceToNextQuestion() -> Bool
    func currentQuestion() -> Question
    func markQuestionRight(_ question: Question)
    func markQuestionWrong(_ question: Question)
    
    func questionIndexTitle() -> String
}
