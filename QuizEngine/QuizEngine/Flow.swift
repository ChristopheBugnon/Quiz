//
//  Flow.swift
//  QuizEngine
//
//  Created by Christophe Bugnon on 18/10/2021.
//

import Foundation

protocol Router {
    func routeTo(question: String, answerCallback: @escaping (String) -> Void)
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

    func routeNext(_ question: String) -> (String) -> Void {
        return { [weak self] _ in
            guard let self = self else { return }
            let currentQuestionIndex = self.questions.firstIndex(of: question)!
            let nextQuestion = self.questions[currentQuestionIndex+1]
            self.router.routeTo(question: nextQuestion, answerCallback: self.routeNext(nextQuestion))
        }
    }
}
