//
//  StateView.swift
//  ObservationSample
//
//  Created by Shunya Yamada on 2025/01/26.
//

import SwiftUI

struct StateParentView: View {
    @State private var isShow: Bool = false

    var body: some View {
        let _ = Self._printChanges()

        StateView()

        Toggle(isOn: $isShow) {
            Text("親 View の値を変更")
        }
        .padding()

        Spacer()
    }
}

struct StateView: View {
    // 子 View 側で `@State` で保持しているため、親 View が再描画されてもリセットされない.
    @State private var lesson: Lesson = .init(
        name: "ピアノ",
        participants: [],
        duration: 60
    )

    var body: some View {
        let _ = Self._printChanges()

        Text("レッスン: \(lesson.name)")
            .font(.title)
        Text("参加人数: \(lesson.numberOfParticipants)")

        Button {
            // シングルトンなので親 View が再描画されても値が保持される.
            lesson.addParticipants()
        } label: {
            Text("参加者を増やす")
        }
    }
}

#Preview {
    StateParentView()
}
