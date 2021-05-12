//
//  ContentView.swift
//  Shared
//
//  Created by lben on 2021/5/1.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world 2!")
            .background(Color.red)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Color.gray
            .overlay(
                ContentView()
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.center)
            )
    }
}
