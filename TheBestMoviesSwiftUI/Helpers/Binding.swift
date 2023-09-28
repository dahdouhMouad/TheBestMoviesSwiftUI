//
//  Binding.swift
//  TheBestMoviesSwiftUI
//
//  Created by Macbook Pro on 28/9/2023.
//

import Foundation
import SwiftUI

extension Binding {
    public func defaultValue<T>(_ value: T) -> Binding<T> where Value == Optional<T> {
        Binding<T> {
            wrappedValue ?? value
        } set: {
            wrappedValue = $0
        }
    }
}
