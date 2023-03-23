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
import SwiftUI
import UIKit


struct ShareView: View {
    @Environment(\.openURL) var openURL
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.accentColor)
                        .accessibilityLabel(Text("The OwnYourData App Icon"))
                        .frame(width: 240, height: 240) // Make it twice as large
                }
                .frame(width: geometry.size.width, height: geometry.size.height / 2.5, alignment: .top)
                Spacer().frame(height: 0)
                
                VStack(spacing: 10) {
                    VStack {
                        Text("Share \nHealth Records")
                            .font(.largeTitle)
                            .foregroundColor(Color.accentColor)
                            .multilineTextAlignment(.center)
                        Button(action: {
                            guard let url = URL(string: "x-apple-health://") else {
                                fatalError("Could not create a Health App URL")
                            }
                            openURL(url)
                        }) {
                            Text("Open Health App")
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
                    
                    VStack(spacing: 10) {
                        VStack {
                            Text("Share \nDocuments")
                                .font(.largeTitle)
                                .foregroundColor(Color.accentColor)
                                .multilineTextAlignment(.center)
                            Button(action: {
                                guard let url = URL(string: "x-apple-health://") else {
                                    fatalError("Could not create a Health App URL")
                                }
                                openURL(url)
                            }) {
                                Text("Select Documents")
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
                    }
                }
            }
        }
    }
}
