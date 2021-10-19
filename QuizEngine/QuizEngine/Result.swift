//
//  Result.swift
//  QuizEngine
//
//  Created by Christophe Bugnon on 19/10/2021.
//

import Foundation

struct Result<Question: Hashable, Answer> {
    let answers: [Question: Answer]
    let score: Int
}
