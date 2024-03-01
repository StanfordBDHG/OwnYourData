//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftPackageList
import SwiftUI


struct ContributionsList: View {
    var packages: [Package] = PackageHelper.getPackageList()
    
    var body: some View {
            List {
                Section(footer: Text("This project is licensed under the MIT License.")) {
                    Text("The following list contains all Swift Package dependencies of the SpeziOwnYourData.")
                }
                Section(
                    header: Text("Packages"),
                    footer: Text("Please refer to the individual repository links for packages without license labels.")
                ) {
                    ForEach(packages.sorted(by: { $0.name < $1.name }), id: \.name) { package in
                        PackageCell(package: package)
                    }
                }
            }
                .navigationTitle("License Information")
                .navigationBarTitleDisplayMode(.inline)
    }
}


#if DEBUG
#Preview {
    let mockPackages = [
        Package(
            name: "MockPackage",
            version: "1.0",
            branch: nil,
            revision: "0",
            // We use a force unwrap in the preview as we can not recover from an error here
            // and the code will never end up in a production environment.
            // swiftlint:disable:next force_unwrapping
            repositoryURL: URL(string: "github.com")!,
            license: "MIT License"
        )
    ]
    return ContributionsList(packages: mockPackages)
}
#endif
