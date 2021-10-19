//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Christophe Bugnon on 19/10/2021.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController
    func resultsViewController(for result: Result<Question<String>, String>) -> UIViewController
}

class NavigationControllerRouter: Router {
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory

    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func routeTo(question: Question<String>, answerCallback: @escaping AnswerCallback) {
        let questionViewController = factory.questionViewController(for: question, answerCallback: answerCallback)
        navigationController.pushViewController(questionViewController, animated: true)
    }

    func routeTo(result: Result<Question<String>, String>) {
        let resultViewController = factory.resultsViewController(for: result)
        navigationController.pushViewController(resultViewController, animated: true)
    }
}
