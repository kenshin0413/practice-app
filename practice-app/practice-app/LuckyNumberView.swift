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
                    } else {
                        
                    }
                }
                .foregroundStyle(.black)
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("ラッキーナンバー")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LuckyNumberView(selectedTab: .constant(1))
}
