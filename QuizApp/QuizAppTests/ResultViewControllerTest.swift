//
//  ResultViewControllerTest.swift
//  QuizAppTests
//
//  Created by Christophe Bugnon on 19/10/2021.
//

import Foundation
import XCTest
@testable import QuizApp

class ResultViewControllerTest: XCTestCase {

    func test_viewDidLoad_rendersSummary() {
        let sut = ResultViewController(summary: "a summary")

        _ = sut.view

        XCTAssertEqual(sut.headerLabel.text, "a summary")
    }
}
