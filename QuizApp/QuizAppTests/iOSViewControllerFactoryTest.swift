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
        XCTAssertEqual(makeQuestionController(question: "Q1").question, "Q1")
    }

    func test_questionViewController_singleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController().options, options)
    }

    func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {
        XCTAssertFalse(makeQuestionController().tableView.allowsMultipleSelection)
    }

    // MARK: - Helpers

    private func makeSUT(options: [Question<String>: [String]]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: options)
    }

    private func makeQuestionController(question: String = "") -> QuestionViewController {
        let q = Question.singleAnswer(question)
        let controller = makeSUT(options: [q: options]).questionViewController(for: q, answerCallback: { _ in }) as! QuestionViewController
        _ = controller.view
        return controller
    }
}
