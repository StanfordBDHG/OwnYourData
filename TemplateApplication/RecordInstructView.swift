//
//  RecordInstructView.swift
//  OwnYourData
//
//  Created by Oliver Oppers Aalami on 3/23/23.
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
    @State var capturedImage: ImageState = .empty
    @State var showingPicker = false
    
    
    var body: some View {
        VStack {
            LogoView()
            Spacer()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
    
    struct RecordInstructView_Previews: PreviewProvider {
        static var previews: some View {
            RecordInstructView()
        }
    }
}
