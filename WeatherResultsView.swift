//
//  WeatherView.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import SwiftUI

struct WeatherResultsView: View {
    @EnvironmentObject private var coordinator: DependencyCoordinator
    @StateObject private var viewModel: WeatherResultsViewModel = WeatherResultsViewModel()
    
    var body: some View {
        VStack(spacing: .dimen8) {
            Text(viewModel.title)
                .sunshineOrApocalypseText(fontName: .openSansBold, fontSize: .font20, textColor: .black80)
            Text("\(viewModel.temp)")
                .sunshineOrApocalypseText(fontName: .openSansBold, fontSize: 86, textColor: .blue100)
        }
        .onAppear {
            viewModel.initDependencies(coordinator)
        }
    }
}


class WeatherResultsViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var temp: Int = 0
    
    private var coordinator: DependencyCoordinator?
    
    func initDependencies(_ coordinator: DependencyCoordinator) {
        self.coordinator = coordinator
        
        let weatherState = self.coordinator?.weatherResultsState.getState()
        temp = Int((weatherState?.temp ?? 0.0).rounded())
        setTitle()
    }
    
    private func setTitle() {
        if temp < 20 {
            title = "Apocalypse 🧊"
            return
        }
        
        if temp > 80 {
            title = "Apocalypse 🔥"
            return
        }
        
        title = "Could be sunshine ☀️"
    }
}

#Preview {
    WeatherResultsView()
}
