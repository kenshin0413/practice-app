//
//  ContentView.swift
//  practice-app
//
//  Created by miyamotokenshin on R 7/09/05.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = NumberListViewModel()
    @Binding var selectedTab: Int
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("検索したい数字を入れてください", text: $viewModel.search)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                List {
                    ForEach(viewModel.filteredItems) { item in
                        Text("\(item.value)")
                    }
                    .onDelete { indexSet in
                        viewModel.deleteOffsets = indexSet
                        viewModel.showDeleteAlert = true
                    }
                }
                Slider(value: $viewModel.sliderValue, in: 0...100, step: 1)
                Text("値\(Int(viewModel.sliderValue))")
    
                HStack {
                    Button("偶数を追加") {
                        viewModel.addRandomNumber(OnlyEven: true)
                    }
                    .frame(width: 120, height: 40)
                    .foregroundStyle(.black)
                    .background(.yellow)
                    .cornerRadius(8)
                    
                    Button("数字を追加") {
                        viewModel.addRandomNumber()
                    }
                    .frame(width: 120, height: 40)
                    .foregroundStyle(.black)
                    .background(.green)
                    .cornerRadius(8)
                    
                    Button("奇数を追加") {
                        viewModel.addRandomNumber(OnlyEven: false)
                    }
                    .frame(width: 120, height: 40)
                    .foregroundStyle(.black)
                    .background(.purple)
                    .cornerRadius(8)
                }
                
                Button("リセット") {
                    viewModel.reset()
                }
                .frame(maxWidth: .infinity, minHeight: 40)
                .foregroundStyle(.black)
                .background(.red)
                .cornerRadius(8)
                .padding(.horizontal)
                
                Button("保存") {
                    viewModel.save()
                    selectedTab = 3
                }
                .frame(maxWidth: .infinity, minHeight: 40)
                .foregroundStyle(.black)
                .background(.blue)
                .cornerRadius(8)
                .padding(.horizontal)
            }
            .navigationTitle("数字リスト")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(viewModel.isEditing ? "完了" : "編集") {
                        withAnimation {
                            viewModel.isEditing.toggle()
                        }
                    }
                }
            }
            .environment(\.editMode, .constant(viewModel.isEditing ? EditMode.active : EditMode.inactive))
            
            .alert("出ました！", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                if let matched = viewModel.matchedValue {
                    Text("\(matched)が出ました！")
                }
            }
            .alert("削除しますか？", isPresented: $viewModel.showDeleteAlert, presenting: viewModel.deleteOffsets) { offset in
                Button("削除", role: .destructive) {
                    viewModel.deleteItems(at: offset)
                    viewModel.deleteOffsets = nil
                }
                Button("キャンセル", role: .cancel) {
                    viewModel.deleteOffsets = nil
                }
            } message: { _ in
                Text("選択した数字を削除します。")
            }
        }
    }
}

#Preview {
    ContentView(selectedTab: .constant(1))
}
