//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by Christophe Bugnon on 19/10/2021.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController
    func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController
}
