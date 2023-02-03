//
//  XCAChatGPTWatchApp.swift
//  XCAChatGPTWatch Watch App
//
//  Created by Alfian Losari on 05/02/23.
//

import SwiftUI

@main
struct XCAChatGPTWatch_Watch_AppApp: App {
    
    @StateObject var vm = ViewModel(api: ChatGPTAPI(apiKey: "API_KEY"))
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView(vm: vm)
                    .edgesIgnoringSafeArea([.horizontal, .bottom])
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItemGroup {
                            HStack {
                                Button("Send") {
                                    self.presentInputController(withSuggestions: []) { result in
                                        Task { @MainActor in
                                            guard !result.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
                                    