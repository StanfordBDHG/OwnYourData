//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct Instructions: View {
    let steps: [(offset: Int, element: AnyView)]
    
    
    var body: some View {
        ForEach(steps, id: \.offset) { step in
            HStack {
                Image(systemName: "\(step.offset + 1).circle.fill")
                    .foregroundColor(Color("ButtonColor_light"))
                    .font(.system(size: 45))
                    .frame(minHeight: 90)
                    .padding(.trailing, 10)
                step.element
            }
        }
            .padding(.horizontal)
    }
    
    
    init(steps: [AnyView]) {
        self.steps = Array(steps.enumerated())
    }
    
    init<V: View>(steps: [V]) {
        self.steps = Array(
            steps
                .map {
                    AnyView($0)
                }
                .enumerated()
        )
    }
}

struct Instructions_Previews: PreviewProvider {
    static var previews: some View {
        Instructions(steps: [])
    }
}
