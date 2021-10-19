//
//  Result.swift
//  QuizAppTests
//
//  Created by Christophe Bugnon on 19/10/2021.
//

import Foundation
@testable import QuizEngine

extension Result: Hashable {
    static func make(answers: [Question: Answer], score: Int) -> Result<Question, Answer> {
        return Result(answers: answers, score: score)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(score)
    }

    public static func == (lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}
