//
//  NumberTriviaRepository.swift
//  NumberTriviaSwift
//
//  Created by Rotem Nevgauker on 22/09/2023.
//

import Foundation
import SystemConfiguration

protocol NetworkInfo  {
    func updateConnectivity()
    var isConnected: Bool { get }
}


class NetworkInfoImpl: NetworkInfo {
    private var _isConnected: Bool = true
    
    var isConnected: Bool {
        get {
            updateConnectivity()
            return _isConnected
        }
    }


    internal func updateConnectivity(){
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                    zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }) else {
                _isConnected =  false
                return
            }
            
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
            if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
                _isConnected =  false
                return
            }
            
            let isReachable = flags == .reachable
            let needsConnection = flags == .connectionRequired
            
            _isConnected = isReachable && !needsConnection
        
        }
}
