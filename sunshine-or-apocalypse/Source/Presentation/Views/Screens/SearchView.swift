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

            TextField("", text: $viewModel.addressString)
                .textFieldStyle(SunshineOrApocalypseTextFieldStyle())
                .multilineTextAlignment(.leading)
            
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
    @Published var addressString: String = ""
    @Published var searchResultsFound: Bool = false
    @Published var isLoading: Bool = false
    
    private var coordinator: DependencyCoordinator?
    
    func initDependencies(_ coordinator: DependencyCoordinator) {
        self.coordinator = coordinator
    }
    
    func search() {
        isLoading = true
        
        coordinator?.locationService.getCoordinates(fromAddressString: addressString) { coordinates, coordinatesError in
            if coordinatesError {
                self.isLoading = false

                self.displayCoorindatesError()
                return
            }
            
            // The appId is left out on purpose to not commit it to source control.
            let dto = WeatherDto(coordinates: Coordinates(lat: coordinates.lat, long: coordinates.long), units: "imperial", appId: "")
            self.coordinator?.weatherService.fetchWeather(dto: dto) { success, error in
                self.isLoading = false
                
                if error != nil {
                    self.displayError()
                    return
                }
                
                guard let weatherResults = success?.data else {
                    self.displayError()
                    return
                }
                
                let weather = Weather(temp: weatherResults.main.temp, description: weatherResults.weather[0].description)
                self.coordinator?.weatherResultsState.setState(weather: weather)
                self.searchResultsFound = true
            }
        }        
    }
    
    private func displayCoorindatesError() {
        let title = "Invalid location"
        let description = "Please enter a valid location in the following format City, State"
        let positiveAction = AlertAction(title: "OK") { }
        
        self.coordinator?.alertManager.display(SunshineOrApocalypseAlert(title: title, description: description, positiveAction: positiveAction))
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
