//
//  Result.swift
//  QuizEngine
//
//  Created by Christophe Bugnon on 19/10/2021.
//

import Foundation

public struct Result<Question: Hashable, Answer> {
    public let answers: [Question: Answer]
    public let score: Int
}
