//
//  NetworkInfoImplTest.swift
//  NumberTriviaSwiftTests
//
//  Created by Rotem Nevgauker on 24/09/2023.
//

import XCTest
@testable import NumberTriviaSwift

class NetworkInfoImplTests: XCTestCase {
    
    var networkInfoImpl:NetworkInfoImpl!
    override func setUp() {
        super.setUp()
        networkInfoImpl = NetworkInfoImpl()
        
    }
    
    
    //make sure there is a connection while running the test
    func testConnectivityWithConnection() async {
        XCTAssertTrue(networkInfoImpl.isConnected)
    }
    
    //make sure there is NO connection while running the test
    func testConnectivityWithNoConnection() async {
        XCTAssertFalse(networkInfoImpl.isConnected)
    }
}



