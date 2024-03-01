//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct OwnYourDataButton: View {
    enum ButtonAction {
        case action(() -> Void)
        case destination(AnyView)
    }
    
    private let title: String
    private let action: ButtonAction
    
    
    var body: some View {
        switch action {
        case let .action(action):
            Button(action: action) {
                text
            }
        case let .destination(destination):
            NavigationLink(destination: destination) {
                text
            }
        }
    }
    
    private var text: some View {
        Text(title)
            .font(.headline.weight(.bold))
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(10)
            .padding(.horizontal)
    }
    
    
    init(title: String, buttonAction: ButtonAction) {
        self.title = title
        self.action = buttonAction
    }
    
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = .action(action)
    }
    
    init<V: View>(title: String, destination: V) {
        self.title = title
        self.action = .destination(AnyView(destination))
    }
}
