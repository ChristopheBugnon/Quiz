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
        XCTAssertEqual(makeSUT(summary: "a summary").headerLabel.text, "a summary")
    }

    func test_viewDidLoad_rendersAnswers() {
        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: [makeAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }

    func test_viewDidLoad_withCorrectAnswer_configureCell() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1", answer: "A1", isCorrect: true)])

        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell

        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }

    func test_viewDidLoad_withWrongAnswer_configureCell() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1", answer: "A1", wrongAnswer: "wrong", isCorrect: false)])

        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell

        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "wrong")
    }

    // MARK: - Helpers

    private func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }

    private func makeAnswer(question: String = "", answer: String = "", wrongAnswer: String? = nil, isCorrect: Bool = true) -> PresentableAnswer {
        return PresentableAnswer(question: question, answer: answer, wrongAnswer: wrongAnswer, isCorrect: isCorrect)
    }
}
