//
//  NestedObjectView.swift
//  ObservationSample
//
//  Created by Shunya Yamada on 2025/01/26.
//

import SwiftUI

private final class Dice: ObservableObject {
    @Published var number: Int

    init(number: Int) {
        self.number = number
    }

    func roll() {
        number = Int.random(in: 1...6)
    }
}

/// `Dice` を構造体に定義し直したもの.
///
/// - note: 構造体にすることで `willSet` が呼び出されるようになる.
private struct StructDice {
    var number: Int

    mutating func roll() {
        number = Int.random(in: 1...6)
    }
}

@Observable
private final class ObservableDice {
    var number: Int

    init(number: Int) {
        self.number = number
    }

    func roll() {
        number = Int.random(in: 1...6)
    }
}

/// `Dice` の変更を通知するクラス.
///
/// - note: クラスで定義している `dice` のプロパティが更新されても `Game.dice` のプロパティは `willSet` が呼ばれない.
/// `@Publlished` をつけたプロパティは `willSet` が呼ばれた時に View へ変更を通知する.
private final class Game: ObservableObject {
//    @Published var dice: Dice = .init(number: 1)
    @Published var dice: StructDice = .init(number: 1)
}

/// `@Observable` で `Dice` の変更を通知するクラス.
///
/// - note: `Observable` マクロであればネストしていても変更が通知される.
/// `Observable` マクロでは `ObservationRegistar` を利用して値を監視していて `willSet` を利用していないため検知が可能.
@Observable
private final class ObservableGame {
    var dice: ObservableDice = .init(number: 1)
}

struct NestedObjectView: View {
//    @StateObject private var game: Game = .init()
    @State private var game: ObservableGame = .init()

    var body: some View {
        Text("サイコロの目: \(game.dice.number)")
        Button {
            // インスタンス全体を更新するようにすれば `willSet` が呼ばれるため更新されるようになる.
//            game.dice = Dice(number: Int.random(in: 1...6))
            game.dice.roll()
            // `objectWillChange()` は `@Published` をつけたプロパティの `willSet` で呼ばれるメソッド.
            // `@Published` が自動で呼び出すが、手動で呼び出すことで変更を通知することができる.
//            game.objectWillChange.send()
        } label: {
            Text("サイコロを振る")
        }
        Spacer()
    }
}

#Preview {
    NestedObjectView()
}
