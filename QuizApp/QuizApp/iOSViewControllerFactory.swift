//
//  iOSViewControllerFactory.swift
//  QuizApp
//
//  Created by Christophe Bugnon on 19/10/2021.
//

import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {
    private let options: [Question<String>: [String]]

    init(options: [Question<String>: [String]]) {
        self.options = options
    }

    func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController {
        switch question {
        case let .singleAnswer(value):
            return QuestionViewController(question: value, options: options[question]!, selection: { _ in })
        default:
            return UIViewController()
        }
    }

    func resultsViewController(for result: Result<Question<String>, String>) -> UIViewController {
        return UIViewController()
    }
}
