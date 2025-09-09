//
//  ContentView.swift
//  practice-app
//
//  Created by miyamotokenshin on R 7/09/05.
//

import SwiftUI

struct ContentView: View {
    @Binding var items: [Number]
    @State var isEditing = false
    @Binding var selectedTab: Int
    @State var showDeleteAlert = false
    @State private var deleteOffsets: IndexSet?
    @State var search = ""
    var filteredItems: [Number] {
        if search.isEmpty {
            return items
        } else {
            // .filter(メソッド)でitemsから一つずつ要素を調べる
            // 取り出した要素(item) の value を文字列に変換して
            // その文字列に search が含まれているかどうかを判定
            return items.filter { item in "\(item.value)".contains(search) }
        }
    }
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                TextField("検索したい数字を入れてください", text: $search)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                List {
                    ForEach(filteredItems) { item in
                        Text("\(item.value)")
                    }
                    .onDelete { indexSet in
                        deleteOffsets = indexSet
                        showDeleteAlert = true
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
                    NumberStorage.save(items)
                    selectedTab = 2
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
            .alert("削除しますか？", isPresented: $showDeleteAlert, presenting: deleteOffsets) { offset in
                Button("削除", role: .destructive) {
                    deleteItems(at: offset)
                    deleteOffsets = nil
                }
                Button("キャンセル", role: .cancel) {
                    deleteOffsets = nil
                }
            } message: { _ in
                Text("選択した数字を削除します。")
            }
        }
    }
    
    private func deleteItems(at offset: IndexSet) {
        items.remove(atOffsets: offset)
    }
}

#Preview {
    ContentView(items: .constant([
        Number(value: 10),
        Number(value: 20),
        Number(value: 30)
    ]), selectedTab: .constant(1))
}
