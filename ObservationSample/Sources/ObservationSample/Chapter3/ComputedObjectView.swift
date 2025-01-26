//
//  ComputedObjectView.swift
//  ObservationSample
//
//  Created by Shunya Yamada on 2025/01/25.
//

import SwiftUI

/// `ObservableObject` で実装した例.
///
/// - note: `ObservableObject` はオプトイン方式で `@Published` をつけることで監視対象になる.
private final class Counter: ObservableObject {
    @Published var count: Int = 0

    var doubleCount: Int {
        count * 2
    }

    func update() {
        count = count + 1
    }
}

struct ComputedObjectView: View {
    @StateObject private var counter = Counter()

    var body: some View {
        Text(counter.doubleCount.description)

        Button {
            counter.update()
        } label: {
            Text("カウントアップ")
        }

        Spacer()
    }
}

#Preview {
    ComputedObjectView()
}
