
//
//  MessageRowView.swift
//  XCAChatGPT
//
//  Created by Alfian Losari on 02/02/23.
//

import SwiftUI

struct MessageRowView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    let message: MessageRow
    let retryCallback: (MessageRow) -> Void
    
    var imageSize: CGSize {
        #if os(iOS) || os(macOS)
        CGSize(width: 25, height: 25)
        #elseif os(watchOS)
        CGSize(width: 20, height: 20)
        #else
        CGSize(width: 80, height: 80)
        #endif
    }
    
    var body: some View {
        VStack(spacing: 0) {
            messageRow(text: message.sendText, image: message.sendImage, bgColor: colorScheme == .light ? .white : Color(red: 52/255, green: 53/255, blue: 65/255, opacity: 0.5))
            
            if let text = message.responseText {
                Divider()
                messageRow(text: text, image: message.responseImage, bgColor: colorScheme == .light ? .gray.opacity(0.1) : Color(red: 52/255, green: 53/255, blue: 65/255, opacity: 1), responseError: message.responseError, showDotLoading: message.isInteractingWithChatGPT)
                Divider()
            }
        }
    }
    
    func messageRow(text: String, image: String, bgColor: Color, responseError: String? = nil, showDotLoading: Bool = false) -> some View {
        #if os(watchOS)
        VStack(alignment: .leading, spacing: 8) {
            messageRowContent(text: text, image: image, responseError: responseError, showDotLoading: showDotLoading)
        }
        
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(bgColor)
        #else
        HStack(alignment: .top, spacing: 24) {
            messageRowContent(text: text, image: image, responseError: responseError, showDotLoading: showDotLoading)
        }
        #if os(tvOS)
        .padding(32)
        #else
        .padding(16)
        #endif
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(bgColor)
        #endif
    }
    
    @ViewBuilder
    func messageRowContent(text: String, image: String, responseError: String? = nil, showDotLoading: Bool = false) -> some View {
        if image.hasPrefix("http"), let url = URL(string: image) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .frame(width: imageSize.width, height: imageSize.height)
            } placeholder: {
                ProgressView()
            }

        } else {
            Image(image)
                .resizable()
                .frame(width: imageSize.width, height: imageSize.height)
        }
        
        VStack(alignment: .leading) {
            if !text.isEmpty {
                #if os(tvOS)
                responseTextView(text: text)
                #else
                Text(text)
                    .multilineTextAlignment(.leading)
                    #if os(iOS) || os(macOS)
                    .textSelection(.enabled)
                    #endif
                #endif
            }
            
            if let error = responseError {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.leading)
                
                Button("Regenerate response") {
                    retryCallback(message)
                }
                .foregroundColor(.accentColor)
                .padding(.top)
            }