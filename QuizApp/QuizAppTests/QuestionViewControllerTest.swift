//
//  QuestionViewControllerTest.swift
//  QuizAppTests
//
//  Created by Christophe Bugnon on 18/10/2021.
//

import Foundation
import XCTest
@testable import QuizApp

class QuestionViewControllerTest: XCTestCase {

    func test_viewDidLoad_rendersQuestionHeaderText() {
        let sut = QuestionViewController(question: "Q1")

        _ = sut.view

        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
}
