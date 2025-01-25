//
//  SE-400.swift
//  ObservationSample
//
//  Created by Shunya Yamada on 2025/01/25.
//

import Foundation

/// 値が初期化される前にプロパティにアクセスできない仕様が `Observable` マクロと衝突してしまう.
/// そこで [SE-400](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0400-init-accessors.md) の仕組みが取り入れられた.
///
/// - note: 詳しい使い方は [storageRestrictions](https://github.com/swiftlang/swift/blob/main/test/Interpreter/init_accessors.swift) のテストコードを参照.
final class Person {
    let age: Int

    // `init(initializes)` ブロック内で利用するためのプロパティを追加.
    let _name: String
    // `_name`
    var name: String {
        // 引数 `initializes` で指定したプロパティーが `init(initializes)` アクセサブロック内で初期化できるようになる.
        // `access` でアクセスしたいプロパティを指定することもできる.
        @storageRestrictions(initializes: _name, accesses: age)
        init(initializes) {
            // `init(initializes)` で代入された値が `initializes` として渡される.
            self._name = initializes
            print(age)
        }

        get {
            _name
        }
    }

    init(age: Int, name: String) {
        self.age = age
        // ここで `name` の `init(initializes)` が呼ばれる、イニシャライザの `name` に指定した値が渡される.
        self.name = name
    }
}

/// 初期値を設定した場合でも `@storageRestrictions` を利用することもできる.
final class Animal {
    var _age: Int
    var age: Int = 0 {
        @storageRestrictions(initializes: _age)
        init(initializes) {
            self._age = initializes
            print("called first")
        }

        get {
            _age
        }

        set {
            _age = newValue
            print("called second")
        }
    }

    init(age: Int) {
        // イニシャライザが呼ばれると、暗黙的に `age` に初期値である `0` が代入される.
        self.age = age
    }
}
