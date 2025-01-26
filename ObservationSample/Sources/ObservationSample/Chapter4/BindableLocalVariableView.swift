//
//  BindableLocalVariableView.swift
//  ObservationSample
//
//  Created by Shunya Yamada on 2025/01/26.
//

import SwiftUI

struct BindableLocalVariableView: View {
    @State private var lessons = [
        Lesson(
            name: "初めての料理教室",
            participants: [],
            duration: 120
        ),
        Lesson(
            name: "初めてのワイン",
            participants: [],
            duration: 45
        )
    ]

//    @Environment(Lesson.self) private var environmentLesson

    var body: some View {
        List(lessons) { lesson in
            // ローカル変数として `@Bindable` を定義.
            @Bindable var lesson = lesson

            Section(lesson.name) {
                Text("レッスン時間: \(lesson.duration)")
                Stepper(
                    "時間を変える",
                    value: $lesson.duration
                )
            }
        }
    }
}

#Preview {
    BindableLocalVariableView()
}
