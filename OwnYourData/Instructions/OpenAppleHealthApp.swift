//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct OpenAppleHealthApp: View {
    @Environment(\.openURL) private var openURL
    
    
    var body: some View {
        HStack(spacing: 16) {
            Text("Tap Health App \nto get started!")
                .foregroundColor(.accentColor)
                .font(.system(size: 30).weight(.bold))
            Image("AppleHealthAppImage")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.accentColor)
                .accessibilityLabel(Text("Apple Health App"))
                .frame(width: 90, height: 90)
                .shadow(color: .gray, radius: 4)
        }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
            .contentShape(Rectangle())
            .onTapGesture {
                guard let url = URL(string: "x-apple-health://") else {
                    fatalError("Could not create a Health App URL")
                }
                openURL(url)
            }
    }
}


#Preview {
    OpenAppleHealthApp()
}
