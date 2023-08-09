//
// This source file is part of the Stanford OwnYourData Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct OwnYourDataTabView: View {
    enum Tabs: String {
        case home
        case addDataView
        case shareView
        case profileView
    }
    
    
    @AppStorage(StorageKeys.homeTabSelection) var selectedTab = Tabs.home
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Home()
                .tag(Tabs.home)
                .tabItem {
                    Label("HOME_TAB_VIEW_TITLE", systemImage: "house")
                }
            AddDataView()
                .tag(Tabs.addDataView)
                .tabItem {
                    Label("ADD_DATA_TAB_TITLE", systemImage: "plus")
                }
            ShareView()
                .tag(Tabs.shareView)
                .tabItem {
                    Label("SHARE_DATA_TAB_TITLE", systemImage: "square.and.arrow.up")
                }
            ProfileView()
                .tag(Tabs.profileView)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}


#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        OwnYourDataTabView()
    }
}
#endif
