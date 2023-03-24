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
import PDFKit
import SwiftUI
import UIKit


struct AddDataView: View {
    @Environment(\.openURL) var openURL
    @State var showingPicker = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                LogoView()
                Spacer()
                Text("Connect to \nHealth System")
                    .font(.largeTitle)
                    .foregroundColor(Color.accentColor)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                //            Button(action: {
                //                guard let url = URL(string: "x-apple-health://") else {
                //                    fatalError("Could not create a Health App URL")
                //                }
                //                openURL(url)
                //            }) {
                NavigationLink(destination: AddRecordInstructView()) {
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
                
                Spacer().frame(height: 40)
                
                VStack {
                    Text("Take a Photo \nof Document")
                        .font(.largeTitle)
                        .foregroundColor(Color.accentColor)
                        .fontWeight(.medium)
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
                .padding(.bottom, 30)
                .fullScreenCover(isPresented: $showingPicker) {
                    DocumentScanner(document: $document)
                        .background {
                            Color.black.ignoresSafeArea()
                        }
                }
            }
        }
    }
    
    
    struct AddDataView_Previews: PreviewProvider {
        static var previews: some View {
            AddDataView()
        }
    }
}
