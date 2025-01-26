//
//  ChildObjectView.swift
//  ObservationSample
//
//  Created by Shunya Yamada on 2025/01/26.
//

import SwiftUI

private struct Item: Identifiable {
    var name: String
    var isChecked: Bool
    var id: String {
        name
    }

    init(
        name: String,
        isChecked: Bool
    ) {
        self.name = name
        self.isChecked = isChecked
    }
}

/// 変更を通知するクラス.
///
/// - note: `ObservableObject` を継承して利用した場合、1 つの Item を更新しただけでも `@StateObject`を保持する 親 View まで更新通知が走るため、親 View から再描画されてしまう.
private final class ItemModel: ObservableObject {
    @Published var items: [Item] = [
        Item(
            name: "Apple",
            isChecked: false
        ),
        Item(
            name: "Banana",
            isChecked: false
        ),
        Item(
            name: "Meron",
            isChecked: false
        )
    ]

    init() {}
}

/// `Observable` マクロを利用して各プロパティの変更を個別で検知できるようにする.
@Observable
private final class ObservableItem: Identifiable {
    var name: String
    var isChecked: Bool
    var id: String {
        name
    }

    init(
        name: String,
        isChecked: Bool
    ) {
        self.name = name
        self.isChecked = isChecked
    }
}

/// 変更を通知するクラス.
///
/// - note: `Observable` マクロを利用することで
@Observable
private final class ObservableItemModel {
    var items: [ObservableItem] = [
        ObservableItem(
            name: "Apple",
            isChecked: false
        ),
        ObservableItem(
            name: "Banana",
            isChecked: false
        ),
        ObservableItem(
            name: "Meron",
            isChecked: false
        )
    ]

    init() {}
}

private struct ParentObjectView: View {
//    @StateObject var itemModel: ItemModel = .init()
    @State var itemModel: ObservableItemModel = .init()

    var body: some View {
        let _ = Self._printChanges()

        List(itemModel.items) { item in
            // `Observable` マクロのオブジェクトを `@Binding` の値に変換するため `@Bindable` を利用する.
            @Bindable var item = item
            ChildObjectView(
                isChecked: $item.isChecked,
                name: item.name
            )
        }
    }
}

private struct ChildObjectView: View {
    @Binding var isChecked: Bool
    var name: String

    var body: some View {
        let _ = Self._printChanges()

        Toggle(isOn: $isChecked) {
            Text(name)
        }
    }
}

#Preview {
    ParentObjectView()
}
