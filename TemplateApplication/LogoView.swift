//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("Logo")
            .resizable()
            .scaledToFit()
            .foregroundColor(Color.accentColor)
            .accessibilityLabel(Text("The OwnYourData App Icon"))
            .frame(width: 240, height: 240) // Make it twice as large
            . padding(.vertical, -40)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
