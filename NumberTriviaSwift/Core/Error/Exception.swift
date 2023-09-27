//
//  Exception.swift
//  NumberTriviaSwift
//
//  Created by Rotem Nevgauker on 22/09/2023.
//

import Foundation

enum ServerException: Error {
    case ServerException
    case CacheException
    case JSONSerializationException
}

