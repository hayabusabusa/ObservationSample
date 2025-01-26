//
//  EnvironmentValues+Extensions.swift
//  ObservationSample
//
//  Created by Shunya Yamada on 2025/01/26.
//

import SwiftUI

extension EnvironmentValues {
    var lesson: Lesson {
        get { self[LessonKey.self] }
        set { self[LessonKey.self] = newValue }
    }
}

private struct LessonKey: @preconcurrency EnvironmentKey {
    @MainActor static var defaultValue: Lesson = Lesson(
        name: "初めてのギター",
        participants: [],
        duration: 60
    )
}
