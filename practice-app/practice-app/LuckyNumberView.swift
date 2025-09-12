//
//  LuckyNumberView.swift
//  practice-app
//
//  Created by miyamotokenshin on R 7/09/12.
//

import SwiftUI

struct LuckyNumberView: View {
    @State var inputValue = ""
    @AppStorage("savedNumber") var savedNumber: Int?
    @Binding var selectedTab: Int
    var body: some View {
        NavigationStack {
            VStack {
                TextField("ラッキーナンバーを入力してください", text: $inputValue)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button("保存") {
                    if let num = Int(inputValue), (0...100).contains(num) {
                        savedNumber = num
                        inputValue = ""
                        selectedTab = 1
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
