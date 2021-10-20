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
    private let options = ["A1", "A2"]

    func test_questionViewController_singleAnswer_createsControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: Question.singleAnswer("Q1")).question, "Q1")
    }

    func test_questionViewController_singleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: Question.singleAnswer("Q1")).options, options)
    }

    func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {
        XCTAssertFalse(makeQuestionController(question: Question.singleAnswer("Q1")).tableView.allowsMultipleSelection)
    }

    func test_questionViewController_multiplesAnswers_createsControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: Question.multipleAnswer("Q1")).question, "Q1")
    }

    func test_questionViewController_multiplesAnswers_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: Question.multipleAnswer("Q1")).options, options)
    }

    func test_questionViewController_multiplesAnswers_createsControllerWithSingleSelection() {
        XCTAssertTrue(makeQuestionController(question: Question.multipleAnswer("Q1")).tableView.allowsMultipleSelection)
    }

    // MARK: - Helpers

    private func makeSUT(options: [Question<String>: [String]]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: options)
    }

    private func makeQuestionController(question: Question<String>) -> QuestionViewController {
        let controller = makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
        _ = controller.view
        return controller
    }
}
