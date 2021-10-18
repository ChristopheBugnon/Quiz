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
}

class Flow {
    let questions: [String]
    let router: Router

    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }

    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(firstQuestion))
        }
    }

    func routeNext(_ question: String) -> Router.AnswerCallback {
        return { [weak self] _ in
            guard let self = self else { return }
            if let currentQuestionIndex = self.questions.firstIndex(of: question) {
                if currentQuestionIndex+1 < self.questions.count {
                    let nextQuestion = self.questions[currentQuestionIndex+1]
                    self.router.routeTo(question: nextQuestion, answerCallback: self.routeNext(nextQuestion))
                }
            }
        }
    }
}
