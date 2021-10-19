//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by Christophe Bugnon on 19/10/2021.
//

import UIKit
import XCTest
import QuizEngine
@testable import QuizApp

class NavigationControllerRouterTest: XCTestCase {
    private let navigationController = NonAnimatedNavigationController()
    private let factory = FactoryViewControllerStub()

    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, factory: self.factory)
    }()

    func test_routeToSecondQuestion_presentsQuestionController() {
        let controller = UIViewController()
        let secondController = UIViewController()
        factory.stub(question: Question.singleAnswer("Q1"), controller: controller)
        factory.stub(question: Question.singleAnswer("Q2"), controller: secondController)

        sut.routeTo(question: Question.singleAnswer("Q1")) { _ in }
        sut.routeTo(question: Question.singleAnswer("Q2")) { _ in }

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, controller)
        XCTAssertEqual(navigationController.viewControllers.last, secondController)
    }

    func test_routeToQuestion_presentsQuestionControllerWithRightCallback() {
        var callBackIsFired: Bool = false

        sut.routeTo(question: Question.singleAnswer("Q1")) { _ in callBackIsFired = true }
        factory.answersCallback[Question.singleAnswer("Q1")]!("A1")

        XCTAssertTrue(callBackIsFired)
    }

    func test_routeToResult_presentsResultsController() {
        let firstController = UIViewController()
        let secondController = UIViewController()
        let questionSingleAnswer = Question.singleAnswer("Q1")
        let questionMultipleAnswer = Question.multipleAnswer("Q2")
        let firstResult = Result.make(answers: [questionSingleAnswer: "A1"], score: 10)
        let secondResult = Result.make(answers: [questionMultipleAnswer: "A2"], score: 20)

        factory.stub(result: firstResult, controller: firstController)
        factory.stub(result: secondResult, controller: secondController)

        sut.routeTo(result: firstResult)
        sut.routeTo(result: secondResult)

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, firstController)
        XCTAssertEqual(navigationController.viewControllers.last, secondController)
    }

    // MARK: - Helpers

    private class FactoryViewControllerStub: ViewControllerFactory {
        private var stubbedQuestions = [Question<String>: UIViewController]()
        private var stubbedResults = [Result<Question<String>, String>: UIViewController]()
        var answersCallback = [Question<String>: (String) -> Void]()

        func stub(question: Question<String>, controller: UIViewController) {
            stubbedQuestions[question] = controller
        }

        func stub(result: Result<Question<String>, String>, controller: UIViewController) {
            stubbedResults[result] = controller
        }

        func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController {
            answersCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }

        func resultsViewController(for result: Result<Question<String>, String>) -> UIViewController {
            return stubbedResults[result] ?? UIViewController()
        }
    }

    class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
}
