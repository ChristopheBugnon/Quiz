//
//  Flow.swift
//  QuizEngine
//
//  Created by Christophe Bugnon on 18/10/2021.
//

import Foundation

protocol Router {
    func routeTo(question: String)
}

class Flow {
    let questions: [String]
    let router: Router

    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }

    func start() {
        if !questions.isEmpty {
            router.routeTo(question: questions.first!)
        }
    }
}
