//
// This source file is part of the Stanford OwnYourData Application project
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
            .foregroundColor(.accentColor)
            .accessibilityLabel(Text("The OwnYourData App Icon"))
            .frame(width: 100, height: 100)
    }
}


struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
