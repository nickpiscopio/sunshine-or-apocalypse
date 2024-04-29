//
//  DependencyCoordinator.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import SwiftUI
import Combine

class DependencyCoordinator: ObservableObject {
    // Services
    @Published var weatherService = WeatherService(repo: WeatherRepository())
    
    // Managers
    @Published var alertManager = AlertManager()
    
    @Published var weatherResultsState = WeatherResultsState()
    
    private var alertManagerCancellable : AnyCancellable?

    init() {
        self.alertManagerCancellable = self.alertManager.$alert.sink(
            receiveValue: { [weak self] _ in
                self?.objectWillChange.send()
            }
        )
    }
}
