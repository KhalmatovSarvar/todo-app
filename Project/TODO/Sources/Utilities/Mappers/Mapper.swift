//
//  Mapper.swift
//  TODO app
//
//  Created by Sarvar on 16/09/25.
//

import Foundation
protocol Mapper {
    associatedtype Input
    associatedtype Output

    func map(_ input: Input) -> Output
}
