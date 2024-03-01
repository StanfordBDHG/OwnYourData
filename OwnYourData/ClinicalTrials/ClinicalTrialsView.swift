//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct ClinicalTrialsView: View {
    var body: some View {
        if let url = URL(string: "https://www.cancer.gov/about-cancer/treatment/clinical-trials/search") {
            WebView(url: url)
        }
    }
}


#Preview {
    ClinicalTrialsView()
}
