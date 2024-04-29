//
//  ContentView.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var coordinator: DependencyCoordinator
    @StateObject private var viewModel: SearchViewModel = SearchViewModel()
    
    var body: some View {
        // I understand the dimentions here are redundant.
        // I like to ensure spacing is not left to iOS' framework as they may decide to change it in the future.
        VStack(alignment: .leading, spacing: .dimen16) {
            Spacer()
            
            Text("Welcome to Sunshine or Apocalypse!")
                .sunshineOrApocalypseTitle()
            
            Text("To get started, please enter the city location in which you would like to see weather results.")
                .sunshineOrApocalypseBody()
            
            Spacer()
            Spacer()

            // Since there is only 1 textfield, I am ok adding this specifically to the view.
            // In the instance there would be another textfield, I would break this out into a fragment view for reusability.
            TextField("", text: $viewModel.city)
                .textFieldStyle(SunshineOrApocalypseTextFieldStyle())
                .multilineTextAlignment(.leading)
                .cornerRadius(viewModel.cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: viewModel.cornerRadius)
                        .stroke(Color.sunshineOrApocalypseBlack50, lineWidth: 2)
                )
            
            Button {
                viewModel.search()
            } label: {
                PrimaryButton(buttonText: "Search!", isLoading: viewModel.isLoading)
            }
        }
        .navigate(to: WeatherResultsView(), when: $viewModel.searchResultsFound)
        .padding(.dimen16)
        .onAppear {
            viewModel.initDependencies(coordinator)
        }
    }
}

class SearchViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var searchResultsFound: Bool = false
    @Published var isLoading: Bool = false
    
    let cornerRadius: CGFloat = .dimen8
    
    private var coordinator: DependencyCoordinator?
    
    func initDependencies(_ coordinator: DependencyCoordinator) {
        self.coordinator = coordinator
    }
    
    func search() {
        isLoading = true
        
        // The appId is left out on purpose to not commit it to source control.
        // TODO: make the lat/long dynamic.
        let dto = WeatherDto(lat: "44.34", long: "10.99", units: "imperial", appId: "")
        coordinator?.weatherService.fetchWeather(dto: dto) { success, error in
            self.isLoading = false
            
            if error != nil {
                self.displayError()
                return
            }
            
            guard let weatherResults = success?.data?.main else {
                self.displayError()
                return
            }
            
            self.coordinator?.weatherResultsState.setState(weather: weatherResults)
            self.searchResultsFound = true
        }
    }
    
    private func displayError() {
        let title = "It's not looking good 😟"
        let description = "It appears we couldn't retrieve the weather information for that location. Maybe the apocalypse has started or maybe your internet is out. Take affirmative action if needed."
        let positiveAction = AlertAction(title: "OK") { }
        
        self.coordinator?.alertManager.display(SunshineOrApocalypseAlert(title: title, description: description, positiveAction: positiveAction))
    }
}

#Preview {
    SearchView()
}
