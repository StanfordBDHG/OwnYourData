//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct OpenAppleHealthApp: View {
    @Environment(\.openURL) private var openURL
    
    
    var body: some View {
        HStack {
            Text("Tap Health App \nto get started!")
                .foregroundColor(.accentColor)
                .font(.system(size: 30).weight(.bold))
                .padding(.leading, 40)
                .padding(.trailing, 10)
            Image("AppleHealthAppImage")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.accentColor)
                .accessibilityLabel(Text("Apple Health App"))
                .frame(width: 90, height: 90)
        }
            .padding(.bottom, 30)
            .contentShape(Rectangle())
            .onTapGesture {
                guard let url = URL(string: "x-apple-health://") else {
                    fatalError("Could not create a Health App URL")
                }
                openURL(url)
            }
    }
}


struct OpenAppleHealthApp_Previews: PreviewProvider {
    static var previews: some View {
        OpenAppleHealthApp()
    }
}
