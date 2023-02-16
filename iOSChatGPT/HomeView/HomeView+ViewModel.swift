//
//  HomeView+ViewModel.swift
//  iOSChatGPT
//
//  Created by Dante Hargrow on 2/15/23.
//
import SwiftUI
import OpenAISwift

extension HomeView {
    struct QuestionAnswer: Identifiable {
        let id = UUID()
        
        let question: String
        var answer: String
    }
    
    class ViewModel: ObservableObject {
        
        let openAi = OpenAISwift(authToken: Environment.apiKey)
        
        @Published var searchString: String = ""
        @Published var questionAndAnswers: [QuestionAnswer] = []
        
        
        func performAISearch() {
            openAi.sendCompletion(with: searchString) { result in
                switch result {
                case .success(let success):
                    let questionAndAnswer = QuestionAnswer(question: self.searchString, answer: success.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
                    
                    self.questionAndAnswers.append(questionAndAnswer)
                    self.searchString = ""
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
        
        func buttonClicked() {
            if !self.searchString.isEmpty {
                self.performAISearch()
            }
            
        }
    }
    
}
