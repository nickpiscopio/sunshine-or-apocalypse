//
//  SunshineOrApocalypseAlert.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import Foundation

struct SunshineOrApocalypseAlert: Identifiable {
    var id =  UUID()
    var title: String
    var description: String
    var positiveAction: AlertAction
    var negativeAction: AlertAction?
}

struct AlertAction {
    var title: String
    var action: () -> Void
}
