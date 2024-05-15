//
//  NetworkMonitor.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 14/05/2024.
//

import Foundation
import Network
import Combine

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected = PassthroughSubject<Bool, Never>()
    
    private(set) var connectionStatus = true { didSet {isConnected.send(connectionStatus)} }
    
    
    // Class methods
    private init() { monitor = NWPathMonitor() }
    
    func startMonitoring() {
        let queue = DispatchQueue(label: "NetwrokMonitor")
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            self.connectionStatus = path.status == .satisfied
        }
    }
}
