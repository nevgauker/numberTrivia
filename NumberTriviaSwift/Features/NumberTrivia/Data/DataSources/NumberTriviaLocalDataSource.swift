//
//  NumberTriviaLocalDataSource.swift
//  NumberTriviaSwift
//
//  Created by Rotem Nevgauker on 22/09/2023.
//

import Foundation

protocol NumberTriviaLocalDataSource {
    /// Gets the cached [NumberTriviaModel] which was gotten the last time
    /// the user had an internet connection.
    ///
    /// Throws [NoLocalDataException] if no cached data is present.
    func getLastNumberTrivia() async throws-> NumberTriviaModel
    
    func cacheNumberTrivia(triviaToCache:NumberTriviaModel) async
}
