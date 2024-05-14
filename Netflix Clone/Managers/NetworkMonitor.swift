//
//  NetworkMonitor.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 14/05/2024.
//

import Foundation
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected = true
    
    private init() { monitor = NWPathMonitor() }
    
    func startMonitoring() {
        let queue = DispatchQueue.main
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
    }
    
}
