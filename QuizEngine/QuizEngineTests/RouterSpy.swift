//
//  RouterSpy.swift
//  QuizEngineTests
//
//  Created by Christophe Bugnon on 19/10/2021.
//

import Foundation
import QuizEngine

class RouterSpy: Router {
    var routedQuestions: [String] = []
    var routedResult: Result<String, String>? = nil
    var answerCallback: AnswerCallback = { _ in }

    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }

    func routeTo(result: Result<String, String>) {
        self.routedResult = result
    }
}
