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
        GeometryReader { geometry in
            VStack {
                VStack {
                    Image("AppIcon")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.accentColor)
                        .accessibilityLabel(Text("The OwnYourData App Icon"))
                        .frame(width: 240, height: 240) // Make it twice as large
                        .accessibility(label: Text("profile image"))
                }
                .frame(width: geometry.size.width, height: geometry.size.height / 2.5, alignment: .top)
                Spacer().frame(height: 0)
                
                VStack(spacing: 10) {
                    VStack {
                        Text("Connect to \nHealth System")
                            .font(.largeTitle)
                            .foregroundColor(Color.accentColor)
                            .multilineTextAlignment(.center)
                        Button(action: {
                            guard let url = URL(string: "x-apple-health://") else {
                                fatalError("Could not create a Health App URL")
                            }
                            openURL(url)
                        }) {
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
                    }
                    
                    Spacer().frame(height: 40)
                    
                    VStack {
                        Text("Take a Photo \nof Document")
                            .font(.largeTitle)
                            .foregroundColor(Color.accentColor)
                            .multilineTextAlignment(.center)
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
}
