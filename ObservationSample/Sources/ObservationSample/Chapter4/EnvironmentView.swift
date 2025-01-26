//
//  EnvironmentView.swift
//  ObservationSample
//
//  Created by Shunya Yamada on 2025/01/26.
//

import SwiftUI

struct EnvironmentListView: View {
//    @State private var lessonState: Lesson = .init(
//        name: "英語初級",
//        participants: [],
//        duration: 90
//    )

    var body: some View {
        List {
            NavigationLink {
                SecondEnvironmentView()
            } label: {
                Text("EnvironmentListView")
            }
        }
    }
}

struct SecondStateView: View {
    // ここでは本来 `Lesson` を渡す必要はない.
    var lesson: Lesson

    var body: some View {
        ThirdStateView(lesson: lesson)
    }
}

struct SecondEnvironmentView: View {
    var body: some View {
        ThirdEnvironmentView()
    }
}

struct ThirdStateView: View {
    var lesson: Lesson

    var body: some View {
        Text(lesson.name)
        Spacer()
    }
}

struct ThirdEnvironmentView: View {
    @Environment(\.lesson) private var lessonByEnvironmentKey
    @Environment(Lesson.self) private var lessonByType

    var body: some View {
        Text("by key: \(lessonByEnvironmentKey.name)")
        Text("by Type: \(lessonByType.name)")
        Spacer()
    }
}

#Preview {
    let lesson = Lesson(
        name: "ピアノ初級",
        participants: [],
        duration: 60
    )

    return NavigationView {
        NavigationLink {
            EnvironmentListView()
        } label: {
            Text("EnvironmentListView")
        }
    }
    // `keyPath` を利用するパターンでは事前に `EnvironmentKey` の実装が必要.
    .environment(
        \.lesson,
         lesson
    )
    // 初期値を渡して型から取り出すものもある.
    .environment(
        Lesson(
            name: "初めての中国語",
            participants: [],
            duration: 60
        )
    )
}
