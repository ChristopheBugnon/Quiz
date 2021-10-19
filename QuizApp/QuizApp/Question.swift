//
//  Question.swift
//  QuizApp
//
//  Created by Christophe Bugnon on 19/10/2021.
//

import Foundation

enum Question<T: Hashable>: Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)
}
