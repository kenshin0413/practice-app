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
    @State var items = [Number(value: 1)]
    @State var isEditing = false
    @State var showSavedList = false
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                List {
                    ForEach(items) { item in
                        Text("\(item.value)")
                    }
                    .onDelete { indexSet in
                        items.remove(atOffsets: indexSet)
                    }
                }
                
                Button("数字を追加") {
                    let newvalue = Int.random(in: 0...100)
                    items.append(Number(value: newvalue))
                }
                .frame(width: 150, height: 40)
                .foregroundStyle(.black)
                .background(.green)
                .cornerRadius(8)
                
                Button("リセット") {
                    items = []
                }
                .frame(width: 150, height: 40)
                .foregroundStyle(.black)
                .background(.red)
                .cornerRadius(8)
                Button("保存") {
                    showSavedList = true
                }
                .frame(width: 150, height: 40)
                .foregroundStyle(.black)
                .background(.blue)
                .cornerRadius(8)
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
            .navigationDestination(isPresented: $showSavedList) {
                SavedListView(items: $items)
            }
        }
    }
}

#Preview {
    ContentView()
}
