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
import UIKit


struct ViewRecordsView: View {
    @Environment(\.openURL) var openURL
    let accentColor = Color("AccentColor")
    let buttonColorLight = Color("ButtonColor_light")
    let appleHealthAppImage = Image("AppleHealthAppImage")
    let browseTabImage = Image("BrowseTabImage")
    let sfSymbols = ["1.circle.fill", "2.circle.fill", "3.circle.fill"]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("How It Works")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color.accentColor)
                    .padding(.leading, 90)
            }
            Spacer()
            HStack {
                Image(systemName: "1.circle.fill")
                    .foregroundColor(Color(UIColor(named: "ButtonColor_light") ?? .gray))
                    .font(.title)
                    .frame(width: 90, height: 90)
                Text("Open the Apple Health App")
                    .foregroundColor(Color.accentColor)
                    .font(.title3)
                Spacer()
                Image("AppleHealthAppImage")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.accentColor)
                    .frame(width: 90, height: 90)
                    .padding(.trailing, 20)
            }
            HStack {
                Image(systemName: "2.circle.fill")
                    .foregroundColor(Color(UIColor(named: "ButtonColor_light") ?? .gray))
                    .font(.title)
                    .frame(width: 90, height: 90)
                Text("Go to the \"Browse\" Tab")
                    .foregroundColor(Color.accentColor)
                    .font(.title3)
                Spacer()
                Image("BrowseTabImage")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.accentColor)
                    .frame(width: 120, height: 120)
                    .padding(.trailing, 0)
                    
            }
            HStack {
                Image(systemName: "3.circle.fill")
                    .foregroundColor(Color(UIColor(named: "ButtonColor_light") ?? .gray))
                    .font(.title)
                    .frame(width: 90, height: 90)
                Text("Select the records you would like to view!")
                    .foregroundColor(Color.accentColor)
                    .font(.title3)
                    .padding(.trailing, 50)
            }
            Spacer()
            HStack {
                Text("Tap Health App \nto get started!")
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 30))
                    .bold()
                    .padding(.leading, 40)
                    .padding(.trailing, 10)
                    .padding(.bottom, 30)
                
                Image("AppleHealthAppImage")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.accentColor)
                    .frame(width: 90, height: 90)
                    .padding(.bottom, 30)
                    .onTapGesture {
                        guard let url = URL(string: "x-apple-health://") else {
                            fatalError("Could not create a Health App URL")
                        }
                        openURL(url)
                    }
            }
        }
        
    }
}
struct ViewRecordsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordInstructView()
    }
}

