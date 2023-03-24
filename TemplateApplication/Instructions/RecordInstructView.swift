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


struct RecordInstructView: View {
    @Environment(\.openURL) var openURL
    
    
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
                    .accessibilityLabel(Text("Apple Health App"))
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
                    .accessibilityLabel(Text("Apple Health App"))
                    .foregroundColor(Color.accentColor)
                    .frame(width: 120, height: 120)
                    .padding(.trailing, 0)
            }
            HStack {
                Image(systemName: "3.circle.fill")
                    .foregroundColor(Color(UIColor(named: "ButtonColor_light") ?? .gray))
                    .font(.title)
                    .frame(width: 90, height: 90)
                Text("Scroll and select Health Records to share")
                    .foregroundColor(Color.accentColor)
                    .font(.title3)
                    .padding(.trailing, 150)
            }
            HStack {
                Image(systemName: "4.circle.fill")
                    .foregroundColor(Color(UIColor(named: "ButtonColor_light") ?? .gray))
                    .font(.title)
                    .frame(width: 90, height: 90)
                Text("Tap \"Export PDF\" on the top right to share PDF")
                    .foregroundColor(Color.accentColor)
                    .font(.title3)
                    .padding(.trailing, 10)
                Spacer()
                Image("ExportIconImage")
                    .resizable()
                    .scaledToFit()
                    .accessibilityLabel(Text("Apple Health App"))
                    .foregroundColor(Color.accentColor)
                    .frame(width: 90, height: 90)
                    .padding(.trailing, 10)
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
                    .accessibilityLabel(Text("Apple Health App"))
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
struct RecordInstructView_Previews: PreviewProvider {
    static var previews: some View {
        RecordInstructView()
    }
}
