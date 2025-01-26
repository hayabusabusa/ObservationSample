//
//  ComputedObserverView.swift
//  ObservationSample
//
//  Created by Shunya Yamada on 2025/01/25.
//

import SwiftUI

/// `Observable` マクロを利用した例.
///
/// - note: `Observable` マクロはオプトアウト方式で、監視対象にしたくないものを後から指定する.
@Observable
private class Counter {
    // `ObservationIgnored` を付与することで監視対象外になって更新されなくなる.
    @ObservationIgnored var count: Int = 0

    var doubleCount: Int {
        count * 2
    }

    func update() {
        count = count + 1
    }
}

struct ComputedObserverView: View {
    @State private var counter = Counter()

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
    ComputedObserverView()
}
