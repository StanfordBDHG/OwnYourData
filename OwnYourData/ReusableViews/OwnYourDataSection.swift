//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct OwnYourDataSection: View {
    private let title: String
    private let buttonTitle: String
    private let buttonAction: OwnYourDataButton.ButtonAction
    
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle.weight(.medium))
                .foregroundColor(.accentColor)
                .multilineTextAlignment(.center)
            OwnYourDataButton(
                title: buttonTitle,
                buttonAction: buttonAction
            )
        }
    }
    
    
    init(title: String, buttonTitle: String, buttonAction: OwnYourDataButton.ButtonAction) {
        self.title = title
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
    
    init(title: String, buttonTitle: String, action: @escaping () -> Void) {
        self.title = title
        self.buttonTitle = buttonTitle
        self.buttonAction = .action(action)
    }
    
    init<V: View>(title: String, buttonTitle: String, destination: V) {
        self.title = title
        self.buttonTitle = buttonTitle
        self.buttonAction = .destination(AnyView(destination))
    }
}
