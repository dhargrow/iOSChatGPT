//
//  Environment.swift
//  iOSChatGPT
//
//  Created by Dante Hargrow on 2/15/23.
//

import Foundation

public enum Environment {
    enum keys {
        static let apiKey = "API_KEY"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        
        return dict
    }()
    
    static let apiKey: String = {
        guard let apiKeyString = Environment.infoDictionary[keys.apiKey] as? String else {
            fatalError("API Ket not set in plist")
        }
        
        return apiKeyString
    }()
}
