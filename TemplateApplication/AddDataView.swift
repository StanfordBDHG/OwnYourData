//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import CardinalKit
import FHIR
import HealthKitDataSource
import HealthKitToFHIRAdapter
import ImageSource
import SwiftUI
import TemplateSharedContext
import UIKit


struct AddDataView: View {
    @Environment(\.openURL) var openURL
    @State var capturedImage: ImageState = .empty
    @State var showingPicker = false
    
    
    var body: some View {
        VStack(spacing: 60) { // Increase spacing between elements
            Image("AppIcon") // Add the AppIcon image
                .resizable()
                .scaledToFit()
                .accessibilityLabel(Text("The OwnYourData App Icon"))
                .frame(width: 100, height: 100)
            VStack(spacing: 40) {
                VStack {
                    Text("Connect to Health System")
                        .font(.largeTitle)
                        .foregroundColor(Color.accentColor)
                    Button(
                        action: {
                            guard let url = URL(string: "https://apps.apple.com/us/app/apple-health/id123456789") else {
                                fatalError("Could not encode URL from static string.")
                            }
                            openURL(url)
                        },
                        label: {
                            Text("Select Health System")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.white)
                                .background(Color(UIColor(named: "ButtonColor_light") ?? .gray))
                                .cornerRadius(10)
                                .padding(.leading)
                                .padding(.trailing)
                        }
                    )
                }
                VStack {
                    Text("Take a Photo of Document")
                        .font(.largeTitle)
                        .foregroundColor(Color.accentColor)
                    Button(action: {
                        self.showingPicker.toggle()
                    }) {
                        Text("Go to Camera")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.white)
                            .background(Color(UIColor(named: "ButtonColor_light") ?? .gray))
                            .cornerRadius(10)
                            .padding(.leading)
                            .padding(.trailing)
                    }
                }
            }.sheet(isPresented: $showingPicker) {
                Camera(image: $capturedImage)
            }
        }
    }
}
