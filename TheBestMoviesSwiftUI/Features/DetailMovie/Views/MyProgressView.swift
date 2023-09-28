//
//  MyProgressView.swift
//  TheBestMoviesSwiftUI
//
//  Created by Macbook Pro on 28/9/2023.
//

import SwiftUI

struct MyProgressView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(.red)
                    .frame(width: proxy.size.width , height: 40)
                Text("Loading...")
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct MyProgressView_Previews: PreviewProvider {
    static var previews: some View {
        MyProgressView()
    }
}
