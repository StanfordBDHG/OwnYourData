//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI

struct HowItWorks: View {
    private let steps: [AnyView]
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("How It Works")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color.accentColor)
                        .padding(.leading, 90)
                }
                Spacer()
                Instructions(steps: steps)
                Spacer()
                OpenAppleHealthApp()
            }
        }
    }
    
    
    init(steps: [AnyView]) {
        self.steps = steps
    }
    
    init<V: View>(steps: [V]) {
        self.steps = steps.map { AnyView($0) }
    }
}


struct HowItWorks_Previews: PreviewProvider {
    static var previews: some View {
        HowItWorks(steps: [])
    }
}
