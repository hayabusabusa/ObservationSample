//
//  Lesson.swift
//  ObservationSample
//
//  Created by Shunya Yamada on 2025/01/26.
//

import Foundation

@Observable
final class Lesson: Identifiable {
    /// レッスン名.
    var name: String
    /// 参加者.
    private(set) var participants: [Participant]
    /// レッスン時間.
    var duration: Int

    var numberOfParticipants: Int {
        participants.count
    }

    init(
        name: String,
        participants: [Participant],
        duration: Int
    ) {
        self.name = name
        self.participants = participants
        self.duration = duration
    }

    func addParticipants() {
        let newName = [
            "Jobs",
            "Cook",
            "Federighi",
            "Hausler"
        ]

        guard let name = newName.randomElement() else {
            return
        }
        participants.append(Participant(name: name))
    }
}

@Observable
final class SingletonLesson {
    let name: String
    private(set) var participants: [Participant]
    private(set) var duration: Int

    var numberOfParticipants: Int {
        participants.count
    }

    @MainActor
    static let shared: SingletonLesson = {
        let lesson = SingletonLesson(
            name: "ピアノ",
            participants: [],
            duration: 60
        )
        return lesson
    }()

    private init(
        name: String,
        participants: [Participant],
        duration: Int
    ) {
        self.name = name
        self.participants = participants
        self.duration = duration
    }

    func addParticipants() {
        let newName = [
            "Jobs",
            "Cook",
            "Federighi",
            "Hausler"
        ]

        guard let name = newName.randomElement() else {
            return
        }
        participants.append(Participant(name: name))
    }
}

struct Participant {
    var name: String
}
