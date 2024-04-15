//
//  SessionFakeProtocol.swift
//  RecipleaseTests
//
//  Created by François-Xavier on 13/04/2024.
//

import Foundation

class SessionFakeProtocol: URLProtocol {
    
    static var loadingData: (() -> (HTTPURLResponse?, Data?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        let handler = SessionFakeProtocol.loadingData!
        let (response, data) = handler()
        
        guard let response = response else {
            client?.urlProtocolDidFinishLoading(self)
            return
        }
        
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
    
}
