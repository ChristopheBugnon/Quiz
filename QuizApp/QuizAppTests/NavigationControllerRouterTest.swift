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

    func test_routeToSecondQuestion_presentsQuestionController() {
        let navigationController = UINavigationController()
        let factory = FactoryViewControllerStub()
        let controller = UIViewController()
        let secondController = UIViewController()
        factory.stub(question: "Q1", controller: controller)
        factory.stub(question: "Q2", controller: secondController)

        let sut = NavigationControllerRouter(navigationController, factory: factory)

        sut.routeTo(question: "Q1") { _ in }
        sut.routeTo(question: "Q2") { _ in }

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, controller)
        XCTAssertEqual(navigationController.viewControllers.last, secondController)
    }

    func test_routeToQuestion_presentsQuestionControllerWithRightCallback() {
        let navigationController = UINavigationController()
        let factory = FactoryViewControllerStub()
        let controller = UIViewController()
        factory.stub(question: "Q1", controller: controller)
        let sut = NavigationControllerRouter(navigationController, factory: factory)

        var callBackIsFired: Bool = false
        sut.routeTo(question: "Q1") { _ in callBackIsFired = true }

        factory.answersCallback["Q1"]!("A1")

        XCTAssertTrue(callBackIsFired)
    }

    class FactoryViewControllerStub: ViewControllerFactory {
        private var stubbedQuestions = [String: UIViewController]()
        var answersCallback = [String: (String) -> Void]()

        func stub(question: String, controller: UIViewController) {
            stubbedQuestions[question] = controller
        }

        func questionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController {
            answersCallback[question] = answerCallback
            return stubbedQuestions[question]!
        }
    }
}
