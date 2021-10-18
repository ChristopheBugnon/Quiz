//
//  Flow.swift
//  QuizEngine
//
//  Created by Christophe Bugnon on 18/10/2021.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
    func routeTo(result: [String: String])
}

class Flow {
    private let questions: [String]
    private let router: Router

    private var result: [String: String] = [:]

    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }

    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(firstQuestion))
        } else {
            router.routeTo(result: result)
        }
    }

    private func routeNext(_ question: String) -> Router.AnswerCallback {
        return { [weak self] answer in
            guard let self = self else { return }

            if let currentQuestionIndex = self.questions.firstIndex(of: question) {
                self.result[question] = answer
                if currentQuestionIndex+1 < self.questions.count {
                    let nextQuestion = self.questions[currentQuestionIndex+1]
                    self.router.routeTo(question: nextQuestion, answerCallback: self.routeNext(nextQuestion))
                } else {
                    self.router.routeTo(result: self.result)
                }
            }
        }
    }
}
