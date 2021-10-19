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
    func test_questionViewController_createsControllerWithQuestion() {
        let sut = iOSViewControllerFactory(options: [Question.singleAnswer("Q1"): ["A1"]])

        let controller = sut.questionViewController(for: Question.singleAnswer("Q1"), answerCallback: { _ in }) as? QuestionViewController

        XCTAssertNotNil(controller)
        XCTAssertEqual(controller?.question, "Q1")
    }

    func test_questionViewController_createsControllerWithOptions() {
        let sut = iOSViewControllerFactory(options: [Question.singleAnswer("Q1"): ["A1", "A2"]])

        let controller = sut.questionViewController(for: Question.singleAnswer("Q1"), answerCallback: { _ in }) as? QuestionViewController

        XCTAssertNotNil(controller)
        XCTAssertEqual(controller?.options, ["A1", "A2"])
    }

}
