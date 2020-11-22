//
//  DotLoadingView.swift
//  XCAChatGPT
//
//  Created by Alfian Losari on 02/02/23.
//

import SwiftUI

struct DotLoadingView: View {
    
    @State private var showCircle1 = false
    @State private var showCircle2 = false
    @State private var showCircle3 = false
    
    var body: some View {
        HStack {
            Circle()
                .opacity(showCircle1 ? 1 : 0)
            Circle()
                .opacity(showCircle2 ? 1 : 0)
          