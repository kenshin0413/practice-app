//
//  HomeView.swift
//  practice-app
//
//  Created by miyamotokenshin on R 7/09/09.
//

import SwiftUI

struct HomeView: View {
    @State var selectedTab = 1
    @State private var items: [Number] = NumberStorage.load()
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                ContentView(items: $items, selectedTab: $selectedTab)
            }
            .tabItem {
                Label("作成", systemImage: "plus.circle")
            }
            .tag(1)
            
            NavigationStack {
                SavedListView(items: $items)
            }
            .tabItem {
                Label("一覧", systemImage: "list.clipboard")
            }
            .tag(2)
        }
    }
}

#Preview {
    HomeView()
}
