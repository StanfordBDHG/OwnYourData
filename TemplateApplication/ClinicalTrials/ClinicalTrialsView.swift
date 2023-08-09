//
// This source file is part of the Stanford OwnYourData Application project
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

struct ClinicalTrialsView_Previews: PreviewProvider {
    static var previews: some View {
        ClinicalTrialsView()
    }
}
