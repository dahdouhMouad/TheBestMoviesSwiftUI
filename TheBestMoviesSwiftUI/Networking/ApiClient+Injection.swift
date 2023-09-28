//
//  ApiClient+Injection.swift
//  TheBestMoviesSwiftUI
//
//  Created by Macbook Pro on 28/9/2023.
//

import Foundation
import Factory


extension Container {
  public var ApiClientRepository: Factory<ApiClient> {
    self {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json; charset=utf-8"]
        return ApiClient(configuration: configuration)
    }.singleton
  }
}
