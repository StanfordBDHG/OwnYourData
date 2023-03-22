//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import FHIR
import HealthKitDataSource
import TemplateSharedContext
import HealthKitToFHIRAdapter
import CardinalKit
import UIKit


struct AddDataView: View {
    @Environment(\.openURL) var openURL
    @State var capturedImage: UIImage?
    @State var showingPicker: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Image("OwnYourData_Icon_White-1024")
                        .resizable()
                        .foregroundColor(Color.accentColor)
                        .scaledToFit()
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
                            let url = URL(string: "https://apps.apple.com/us/app/apple-health/id123456789")!
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
                        }){
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
                    CameraView(capturedImage: self.$capturedImage)
                }
            }
        }
    }
}
