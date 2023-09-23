import Foundation

protocol DataFailure {
    associatedtype T: Equatable
    var properties: [T] { get }
    init(properties: [T])
}

struct ServerFailure<T: Equatable>: DataFailure {
    let properties: [T]
    
    init(properties: [T] = []) {
        self.properties = properties
    }
}

struct CacheFailure<T: Equatable>: DataFailure {
    let properties: [T]
    
    init(properties: [T] = []) {
        self.properties = properties
    }
}





