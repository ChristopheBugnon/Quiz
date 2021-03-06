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
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }

    func test_viewDidLoad_renderOptions() {
        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0), 2)
    }

    func test_viewDidLoad_rendersOptionsText() {
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 1), "A2")
    }

    func test_optionSelected_withSingleSelection_notifiesDelegate() {
        var receivedAnswers = [String]()
        let sut = makeSUT(options: ["A1"]) { receivedAnswers = $0 }

        sut.tableView.select(row: 0)

        XCTAssertEqual(receivedAnswers, ["A1"])
    }

    func test_optiondeselected_withSingleSelection_doesNotNotifiesDelegate() {
        var callbackCount = 0
        let sut = makeSUT(options: ["A1"]) { _ in callbackCount += 1 }

        sut.tableView.select(row: 0)
        XCTAssertEqual(callbackCount, 1)

        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callbackCount, 1)
    }

    func test_optionSelected_withSingleSelection_notifiesDelegateWithLastSelection() {
        var receivedAnswers = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswers = $0 }

        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswers, ["A1"])

        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswers, ["A2"])
    }

    func test_optionSelected_withMultipleSelectionEnable_notifiesDelegateSelection() {
        var receivedAnswers = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswers = $0 }
        sut.tableView.allowsMultipleSelection = true

        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswers, ["A1"])

        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswers, ["A1", "A2"])
    }

    func test_optionDeselected_withMultipleSelectionEnable_notifiesDelegateSelection() {
        var receivedAnswers = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswers = $0 }
        sut.tableView.allowsMultipleSelection = true

        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswers, ["A1"])

        sut.tableView.deselect(row: 0)
        XCTAssertEqual(receivedAnswers, [])
    }

    // MARK: - Helpers

    private func makeSUT(question: String = "",
                         options: [String] = [],
                         selection: @escaping ([String]) -> Void = { _ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)
        _ = sut.view
        return sut
    }
}
