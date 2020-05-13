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
    
    private let a