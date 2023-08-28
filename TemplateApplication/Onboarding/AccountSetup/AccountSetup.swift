//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import FirebaseAuth
import FirebaseFirestore
import SpeziAccount
import SpeziFirebaseAccount
import SpeziOnboarding
import SwiftUI


struct AccountSetup: View {
    @EnvironmentObject private var onboardingNavigationPath: OnboardingNavigationPath
    @EnvironmentObject var account: Account
    
    @AppStorage(StorageKeys.firstName) private var firstName = ""
    @AppStorage(StorageKeys.lastName) private var lastName = ""
    @AppStorage(StorageKeys.email) private var email = ""
    
    
    var body: some View {
        OnboardingView(
            contentView: {
                VStack {
                    OnboardingTitleView(
                        title: "ACCOUNT_TITLE",
                        subtitle: "ACCOUNT_SUBTITLE"
                    )
                    Spacer(minLength: 0)
                    accountImage
                    accountDescription
                    Spacer(minLength: 0)
                }
            }, actionView: {
                actionView
            }
        )
            .onReceive(account.objectWillChange) {
                if account.signedIn {
                    guard let user = Auth.auth().currentUser else {
                        return
                    }
                    
                    let fullName = user.displayName?.components(separatedBy: " ")
                    let firstName = fullName?[0] ?? ""
                    let lastName = fullName?[1] ?? ""
                    let email = user.email ?? ""
                    
                    let userData: [String: Any] = [
                        "firstName": firstName,
                        "lastName": lastName,
                        "email": email,
                        "signUpDate": Timestamp()
                    ]
                    
                    Firestore.firestore().collection("users").document(user.uid).setData(userData) { err in
                        if let err {
                            print("Error uploading user data: \(err)")
                        }
                    }
                    
                    self.firstName = firstName
                    self.lastName = lastName
                    self.email = email
                    
                    onboardingNavigationPath.nextStep()
                }
            }
    }
    
    @ViewBuilder private var accountImage: some View {
        Group {
            if account.signedIn {
                Image(systemName: "person.badge.shield.checkmark.fill")
            } else {
                Image(systemName: "person.fill.badge.plus")
            }
        }
            .font(.system(size: 150))
            .foregroundColor(.accentColor)
    }
    
    @ViewBuilder private var accountDescription: some View {
        VStack {
            Group {
                if account.signedIn {
                    Text("ACCOUNT_SIGNED_IN_DESCRIPTION")
                } else {
                    Text("ACCOUNT_SETUP_DESCRIPTION")
                }
            }
                .multilineTextAlignment(.center)
                .padding(.vertical, 16)
            if account.signedIn {
                UserView()
                    .padding()
                Button("Logout", role: .destructive) {
                    try? Auth.auth().signOut()
                }
            }
        }
    }
    
    @ViewBuilder private var actionView: some View {
        if account.signedIn {
            OnboardingActionsView(
                "ACCOUNT_NEXT",
                action: {
                    onboardingNavigationPath.nextStep()
                }
            )
        } else {
            OnboardingActionsView(
                primaryText: "ACCOUNT_SIGN_UP",
                primaryAction: {
                    onboardingNavigationPath.append(customView: TemplateSignUp())
                },
                secondaryText: "ACCOUNT_LOGIN",
                secondaryAction: {
                    onboardingNavigationPath.append(customView: TemplateLogin())
                }
            )
        }
    }
}


#if DEBUG
struct AccountSetup_Previews: PreviewProvider {
    static var previews: some View {
        AccountSetup()
            .environmentObject(Account(accountServices: []))
            .environmentObject(FirebaseAccountConfiguration(emulatorSettings: (host: "localhost", port: 9099)))
    }
}
#endif
