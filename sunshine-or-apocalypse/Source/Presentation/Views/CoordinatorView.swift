//
//  CoordinatorView.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = DependencyCoordinator()
    var body: some View {
        NavigationView {
            SearchView()
        }
        .alert(item: $coordinator.alertManager.alert) { alert in
            guard alert.negativeAction != nil else {
                return Alert(
                    title: Text(alert.title),
                    message: Text(alert.description),
                    dismissButton: .default(Text(alert.positiveAction.title), action: alert.positiveAction.action)
                )
            }
            
            return Alert(
                title: Text(alert.title),
                message: Text(alert.description),
                primaryButton: .destructive(Text(alert.negativeAction?.title ?? ""), action: alert.negativeAction?.action),
                secondaryButton: .default(Text(alert.positiveAction.title), action: alert.positiveAction.action)
            )
        }
        .environmentObject(coordinator)
    }
}
