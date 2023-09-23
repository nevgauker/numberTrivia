//
//  NumberTrivia.swift
//  NumberTriviaSwift
//
//  Created by Rotem Nevgauker on 21/09/2023.
//

import Foundation

class NumberTrivia: Equatable {
    let text: String
    let number: Int
    
    init(text: String, number: Int) {
        self.text = text
        self.number = number
    }
    
    static func == (lhs: NumberTrivia, rhs: NumberTrivia) -> Bool {
        return lhs.text == rhs.text && lhs.number == rhs.number
    }
}







