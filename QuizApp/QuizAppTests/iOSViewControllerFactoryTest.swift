//
//  iOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Christophe Bugnon on 19/10/2021.
//

import UIKit
import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    private let questionSingleAnswer = Question.singleAnswer("Q1")

    func test_questionViewController_singleAnswer_createsControllerWithQuestion() {
        let sut = iOSViewControllerFactory(options: [questionSingleAnswer: ["A1"]])

        let controller = sut.questionViewController(for: questionSingleAnswer, answerCallback: { _ in }) as? QuestionViewController

        XCTAssertNotNil(controller)
        XCTAssertEqual(controller?.question, "Q1")
    }

    func test_questionViewController_singleAnswer_createsControllerWithOptions() {
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [questionSingleAnswer: options])

        let controller = sut.questionViewController(for: questionSingleAnswer, answerCallback: { _ in }) as? QuestionViewController

        XCTAssertNotNil(controller)
        XCTAssertEqual(controller?.options, options)
    }

    func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [questionSingleAnswer: options])

        let controller = sut.questionViewController(for: questionSingleAnswer, answerCallback: { _ in }) as! QuestionViewController
        _ = controller.view

        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }
}
