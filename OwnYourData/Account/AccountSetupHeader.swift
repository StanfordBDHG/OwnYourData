//
// This source file is part of the OwnYourData based on the Stanford Spezi Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SpeziAccount
import SwiftUI


struct AccountSetupHeader: View {
    @Environment(Account.self) private var account: Account?
    @Environment(\._accountSetupState) private var setupState
    
    
    var body: some View {
        VStack {
            Text("Your Account")
                .font(.largeTitle)
                .bold()
                .padding(.bottom)
                .padding(.top, 30)
            Text("ACCOUNT_SUBTITLE")
                .padding(.bottom, 8)
            if account?.signedIn ?? false, case .generic = setupState {
                Text("You signed in with the following account:")
            }
        }
            .multilineTextAlignment(.center)
    }
}


#if DEBUG
#Preview {
    AccountSetupHeader()
        .environment(Account())
}
#endif
