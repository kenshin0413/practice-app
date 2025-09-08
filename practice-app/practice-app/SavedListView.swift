//
//  SavedListView.swift
//  practice-app
//
//  Created by miyamotokenshin on R 7/09/08.
//

import SwiftUI

struct SavedListView: View {
    @Binding var items: [Number]
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    Text("保存された数字は\(item.value)")
                }
            }
            .navigationTitle("保存リスト")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
// 子ビューのプレビューは基本.constantを使ってダミーを書く
#Preview {
    SavedListView(items: .constant([Number(value: 1), Number(value: 2), Number(value: 3)]))
}
