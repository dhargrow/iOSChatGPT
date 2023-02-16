//
//  ContentView.swift
//  iOSChatGPT
//
//  Created by Dante Hargrow on 2/7/23.
//

import SwiftUI
import OpenAISwift

struct QuestionAnswer: Identifiable {
    let id = UUID()

    let question: String
    var answer: String
}

struct ContentView: View {

    let openAi = OpenAISwift(authToken: Environment.apiKey)

    @State private var searchString: String = ""
    @State private var questionAndAnswers: [QuestionAnswer] = []

    private func performAISearch() {
        openAi.sendCompletion(with: searchString) { result in
            switch result {
            case .success(let success):
                let questionAndAnswer = QuestionAnswer(question: searchString, answer: success.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")

                questionAndAnswers.append(questionAndAnswer)
                searchString = ""
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }

    var body: some View {
        NavigationView{
            VStack {
                HStack(alignment: .center) {
                    TextField("Type here", text: $searchString)
                        .onSubmit {
                            if !searchString.isEmpty {
                                performAISearch()
                            }
                        }
                }
                ScrollView {
                    ForEach(questionAndAnswers) { qa in
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
