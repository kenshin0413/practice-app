//
//  LuckyNumberView.swift
//  practice-app
//
//  Created by miyamotokenshin on R 7/09/12.
//

import SwiftUI

struct LuckyNumberView: View {
    @StateObject var viewModel = NumberListViewModel()
    @AppStorage("savedNumber") var savedNumber: Int?
    @Binding var selectedTab: Int
    var body: some View {
        NavigationStack {
            VStack {
                TextField("ラッキーナンバーを入力してください", text: $viewModel.inputValue)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button("保存") {
                    if viewModel.savedLuckyNumber() {
                        selectedTab = 1
                    } else {}
                }
                .foregroundStyle(.black)
                .buttonStyle(.borderedProminent)
                
                Button("リセット") {
                    viewModel.savedNumber = nil
                    viewModel.showDeleteAlert = true
                }
                .foregroundStyle(.black)
                .frame(width: 80, height: 40)
                .background(Color.red)
                .cornerRadius(6)
            }
            .alert("ラッキーナンバーを削除しました。", isPresented: $viewModel.showDeleteAlert) {
                Button("OK", role: .cancel) {}
            }
            .navigationTitle("ラッキーナンバー")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LuckyNumberView(selectedTab: .constant(1))
}
