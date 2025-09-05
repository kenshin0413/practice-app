//
//  ContentView.swift
//  practice-app
//
//  Created by miyamotokenshin on R 7/09/05.
//

import SwiftUI

struct Number: Identifiable {
    let id = UUID()
    let value: Int
}

struct ContentView: View {
    @State var items = [Number(value: 1), Number(value: 2), Number(value: 3)]
    @State var isEditing = false
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(items) { item in
                        Text("数字は\(item.value)")
                    }
                    .onDelete { indexSet in
                        items.remove(atOffsets: indexSet)
                    }
                }
                Button("数字を追加") {
                    let newvalue = Int.random(in: 0...100)
                    items.append(Number(value: newvalue))
                }
            }
            .navigationTitle("数字リスト")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "完了" : "編集") {
                        withAnimation {
                            isEditing.toggle()
                        }
                    }
                }
            }
            .environment(\.editMode, .constant(isEditing ? EditMode.active : EditMode.inactive))
        }
    }
}

#Preview {
    ContentView()
}
