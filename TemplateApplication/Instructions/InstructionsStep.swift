//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI

struct InstructionsStep: View {
    let title: String
    let content: AnyView
    
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.accentColor)
                .font(.title3)
            Spacer()
            content
        }
    }
    
    
    init<StepContent: View>(title: String, @ViewBuilder content: () -> (StepContent)) {
        self.title = title
        self.content = AnyView(content())
    }
    
    init(title: String) {
        self.title = title
        self.content = AnyView(EmptyView())
    }
}


extension InstructionsStep {
    static var openHealthApp: InstructionsStep {
        InstructionsStep(title: "Open the Apple Health App") {
            Image("AppleHealthAppImage")
                .resizable()
                .scaledToFit()
                .accessibilityLabel(Text("Open the Apple Health app."))
                .foregroundColor(.accentColor)
                .frame(width: 90, height: 90)
                .padding(.trailing, 18)
        }
    }
    
    static var browseTab: InstructionsStep {
        InstructionsStep(title: "Go to the \"Browse\" Tab") {
            Image("BrowseTabImage")
                .resizable()
                .scaledToFit()
                .accessibilityLabel(Text("Navigate to the Browse tab."))
                .foregroundColor(Color.accentColor)
                .frame(width: 120, height: 120)
                .padding(.trailing, 0)
        }
    }
}


struct InstructionsStep_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsStep(title: "Instruction") {
            Text("Step Content ...")
        }
    }
}
