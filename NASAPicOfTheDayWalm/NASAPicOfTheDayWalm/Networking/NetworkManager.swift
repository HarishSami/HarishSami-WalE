//
//  NetworkManager.swift
//  NASAPicOfTheDayWalm
//
//  Created by Harish Sami on 21/08/24.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    @Published var isConnected: Bool = true

    init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}

