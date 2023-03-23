//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI

struct ClinicalTrialsView: View {
    var body: some View {
        WebView(url: URL(string: "https://www.cancer.gov/about-cancer/treatment/clinical-trials/search")!)
    }
}

struct ClinicalTrialsView_Previews: PreviewProvider {
    static var previews: some View {
        ClinicalTrialsView()
    }
}
