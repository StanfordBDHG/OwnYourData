//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Contact
import Foundation
import SwiftUI


/// Displays the contacts for the CardinalKit Template Application.
public struct Contacts: View {
    let contacts = [
        Contact(
            name: PersonNameComponents(
                givenName: "Alexa",
                familyName: "Aalami"
            ),
            image: Image(systemName: "figure.wave.circle"),
            title: "Undergrad",
            description: String(localized: "ALEXA_AALAMI_BIO", bundle: .module),
            organization: "Columbia Universityaa",
            address: {
                let address = CNMutablePostalAddress()
                address.country = "USA"
                address.state = "NY"
                address.postalCode = "10027"
                address.city = "New York"
                address.street = "665 W 130th St"
                return address
            }(),
            contactOptions: [
                .call("+1 (650) 315-3241"),
                .text("+1 (650) 315-3241"),
                .email(addresses: ["ara2190@barnard.edu"]),
                ContactOption(
                    image: Image(systemName: "safari.fill"),
                    title: "Website",
                    action: {
                        if let url = URL(string: "https://www.sipa.columbia.edu/global-research-impact/initiatives/sipa-public-policy-challenge-grant") {
                           UIApplication.shared.open(url)
                        }
                    }
                )
            ]
        )
    ]
    
    
    public var body: some View {
        NavigationStack {
            ContactsList(contacts: contacts)
                .navigationTitle(String(localized: "CONTACTS_NAVIGATION_TITLE", bundle: .module))
        }
    }
    
    
    public init() {}
}


#if DEBUG
struct Contacts_Previews: PreviewProvider {
    static var previews: some View {
        Contacts()
    }
}
#endif
