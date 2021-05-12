//
//  ContentView.swift
//  RenderDemo
//
//  Created by lben on 2021/5/9.
//

import Combine
import SwiftUI

// class Avatar: View {
//
//    typealias Body = Label
// }

class LoginViewModel {
    let publisher = Published(initialValue: "你好")
}

let viewmodel = LoginViewModel()

struct ContentView: View {
    var body: some View {
        VStack(content: {
            Text("Hello, world2")
                .padding()
            Text("Hello, world!")
                .padding()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
