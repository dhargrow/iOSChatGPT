//
//  ContentView.swift
//  iOSChatGPT
//
//  Created by Dante Hargrow on 2/7/23.
//

import SwiftUI
import OpenAISwift

struct HomeView: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        NavigationView{
            VStack {
                HStack(alignment: .center) {
                    TextField("Type here", text: $viewModel.searchString)
                }
                VStack {
                    Button(action: viewModel.buttonClicked) {
                        Text("Submit Text")
                            .foregroundColor(Color.white)
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
                ScrollView {
                    ForEach($viewModel.questionAndAnswers) { $qa in
                        VStack(spacing: 10){
                            Text(qa.question)
                            Text(qa.answer)
                        }
                    }
                }
                Spacer()
            }.navigationTitle("ChatGPT for iOS")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .frame(maxWidth: 120, minHeight: 48, alignment: .center)
            .background(configuration.isPressed ? Color.gray : Color.blue)
            .cornerRadius(6)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
