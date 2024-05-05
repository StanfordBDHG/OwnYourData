//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import OpenAPIClient
import SwiftUI


struct ClinicalTrialsView: View {
    var body: some View {
        Button("Request Trials Data") {
            print("Request trials data")
            OpenAPIClientAPI.customHeaders = ["X-API-KEY": "tkMGxBkgOC4TDCUfjcPdw7eeZsuuZual632WpUnH"]
            CodableHelper.dateFormatter = NICTrialsAPIDateFormatter()
            TrialsAPI.getTrialById(id: "NCI-2019-02616") { data, error in
                guard let data else {
                    if let error {
                        print("Error: \(error)")
                    } else {
                        print("Unkown Error")
                    }
                    return
                }
                
                print(data)
            }
        }
    }
}


#Preview {
    ClinicalTrialsView()
}
