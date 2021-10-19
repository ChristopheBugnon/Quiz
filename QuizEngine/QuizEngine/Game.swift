//
//  Game.swift
//  QuizEngineTests
//
//  Created by Christophe Bugnon on 19/10/2021.
//

import Foundation

public class Game<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    private let flow: Flow<Question, Answer, R>

    init(flow: Flow<Question, Answer, R>) {
        self.flow = flow
    }
}

public func startGame<Question, Answer: Equatable, R: Router>(questions: [Question], router: R, correctAnswers: [Question: Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer {
    let flow = Flow(questions: questions, router: router, scoring: { scoring($0, correctAnswers) })
    flow.start()
    return Game(flow: flow)
}

private func scoring<Question: Hashable, Answer: Equatable>(_ answers: [Question: Answer], _ correctAnswers: [Question: Answer]) -> Int {
    answers.reduce(0) { score, tuple in
        return score + (correctAnswers[tuple.key] == tuple.value ? 1 : 0)
    }
}
