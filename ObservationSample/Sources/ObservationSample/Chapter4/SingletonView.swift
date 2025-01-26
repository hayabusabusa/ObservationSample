//
//  SingletonView.swift
//  ObservationSample
//
//  Created by Shunya Yamada on 2025/01/26.
//

import SwiftUI

struct SingletonParentView: View {
    @State private var isShow: Bool = false

    var body: some View {
        let _ = Self._printChanges()

        SingletonView()

        Toggle(isOn: $isShow) {
            Text("親 View の値を変更")
        }
        .padding()

        Spacer()
    }
}

struct SingletonView: View {
    var lesson: SingletonLesson = .shared

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
    SingletonParentView()
}
