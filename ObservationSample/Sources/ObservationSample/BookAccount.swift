//
//  BookAccount.swift
//  ObservationSample
//
//  Created by Shunya Yamada on 2025/01/25.
//

import Foundation

@Observable
final class BookAccount {
    var isBorrowed: Bool = false
    var history: [Date: Bool] = [:]
    var borrowedCount: Int {
        history.filter { $0.value }.count
    }

    func switchBorrow() {
        isBorrowed.toggle()
        history[Date()] = isBorrowed
    }
}
