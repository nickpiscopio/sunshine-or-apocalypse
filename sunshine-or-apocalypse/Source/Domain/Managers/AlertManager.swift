//
//  AlertManager.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import SwiftUI

class AlertManager: ObservableObject {
    @Published var alert: SunshineOrApocalypseAlert? = nil
    
    func display(_ alert: SunshineOrApocalypseAlert) {
        self.alert = alert
    }
    
    func dismiss() {
        self.alert = nil
    }
}
