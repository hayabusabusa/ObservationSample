//
//  PropertyView.swift
//  ObservationSample
//
//  Created by Shunya Yamada on 2025/01/26.
//

import SwiftUI

struct LocalPropertyView: View {
    var lesson: Lesson = .init(
        name: "ピアノ",
        participants: [],
        duration: 60
    )

    var body: some View {
        let _ = Self._printChanges()

        Text("レッスン: \(lesson.name)")
            .font(.title)
        Text("参加者人数: \(lesson.numberOfParticipants)")

        Spacer()
            .frame(height: 12)

        Button {
            lesson.addParticipants()
        } label: {
            Text("参加者を増やす")
        }
        Button {
            // `duration` の方は View から参照されていないため変更しても再描画されない.
            lesson.duration = Int.random(in: 30...60)
        } label: {
            Text("レッスン時間を変える")
        }

        Spacer()
            .frame(height: 8)
    }
}

struct LocalPropertyParentView: View {
    @State var lesson: Lesson = .init(
        name: "ピアノ",
        participants: [],
        duration: 60
    )

    var body: some View {
        LocalPropertyView(lesson: lesson)
    }
}

struct LocalPropertyChildView: View {
    let lesson: Lesson

    var body: some View {
        Text(lesson.name)
    }
}

struct PropertyListView: View {
    @State private var isShow: Bool = false

    var body: some View {
        let _ = Self._printChanges()

        LocalPropertyView()

        // 親 View で再描画が走ってしまうと `LocalPropertyView` の状態が全てリセットされてしまう.
        Toggle(isOn: $isShow) {
            Text("親Viewの値を変更")
        }
        .padding()

        Spacer()
    }
}

#Preview {
    PropertyListView()
}
