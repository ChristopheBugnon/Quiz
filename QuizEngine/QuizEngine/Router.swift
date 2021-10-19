//
//  Router.swift
//  QuizEngine
//
//  Created by Christophe Bugnon on 19/10/2021.
//

import Foundation

protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    typealias AnswerCallback = (Answer) -> Void

    func routeTo(question: Question, answerCallback: @escaping AnswerCallback)
    func routeTo(result: Result<Question, Answer>)
}
