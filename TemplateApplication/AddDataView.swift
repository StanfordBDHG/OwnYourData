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
        VStack(spacing: 60) { // Increase spacing between elements
            Image("AppIcon") // Add the AppIcon image
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            VStack(spacing: 40) {
                VStack {
                    Text("Connect to Health System")
                        .font(.largeTitle)
                        .foregroundColor(Color.accentColor)
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
                
                VStack {
                    Text("Take a Photo of Document")
                        .font(.largeTitle)
                        .foregroundColor(Color.accentColor)
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
