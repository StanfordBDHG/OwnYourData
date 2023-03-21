//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import FHIRMockDataStorageProvider
import SwiftUI
import TemplateContacts
import TemplateSchedule
import TemplateSharedContext


struct HomeView: View {
    enum Tabs: String {
        case schedule
        case contact
        case mockUpload
        case profileView
        case homeTabView
        case addDataView
        case shareView
    }
    
    
    @AppStorage(StorageKeys.homeTabSelection) var selectedTab = Tabs.schedule
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeTabView()
                .tag(Tabs.schedule)
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
//            ScheduleView()
//                .tag(Tabs.schedule)
//                .tabItem {
//                    Label("SCHEDULE_TAB_TITLE", systemImage: "list.clipboard")
//                }
//            Contacts()
//                .tag(Tabs.contact)
//                .tabItem {
//                    Label("CONTACTS_TAB_TITLE", systemImage: "person.fill")
//                }
            
            ProfileView()
                .tag(Tabs.profileView)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
            
//            MockUploadList()
//                .tag(Tabs.mockUpload)
//                .tabItem {
//                    Label("MOCK_UPLOAD_TAB_TITLE", systemImage: "server.rack")
//                }
        }
    }
}


#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(TemplateApplicationScheduler())
            .environmentObject(MockDataStorageProvider())
    }
}
#endif
