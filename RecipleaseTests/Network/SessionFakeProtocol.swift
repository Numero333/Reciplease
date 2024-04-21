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
        // Retrieve the handler that provides the response and data
        let handler = SessionFakeProtocol.loadingData!
        
        // Execute the handler to get the simulated response and data
        let (response, data) = handler()
        
        // Ensure a response is available otherwise notify the client that loading has finished
        guard let response = response else {
            client?.urlProtocolDidFinishLoading(self)
            return
        }
        
        // Notify the client that a response has been received
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        
        // If data is available, send it to the client
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        // Notify the client that loading has finished
        client?.urlProtocolDidFinishLoading(self)
    }
    
    // Stops loading the request
    override func stopLoading() { }
}
