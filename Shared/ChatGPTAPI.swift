//
//  ChatGPTAPI.swift
//  XCAChatGPT
//
//  Created by Alfian Losari on 01/02/23.
//

import Foundation

class ChatGPTAPI: @unchecked Sendable {
    
    private let systemMessage: Message
    private let temperature: Double
    private let model: String
    
    private let apiKey: String
    private var historyList = [Message]()
    private let urlSession = URLSession.shared
    private var urlRequest: URLRequest {
        let url = URL(string: "https://api.openai.com/v1