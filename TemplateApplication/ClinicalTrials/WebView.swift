//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SafariServices
import SwiftUI


struct WebView: UIViewControllerRepresentable {
    var url: URL
    
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    func updateUIViewController(_ safariViewController: SFSafariViewController, context: Context) {}
}
